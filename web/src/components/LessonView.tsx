import { useState, useCallback } from 'react'
import type { ExerciseKind } from '../types'
import { allLessons } from '../data'
import MultipleChoiceExercise from './exercises/MultipleChoiceExercise'
import FillInBlankExercise from './exercises/FillInBlankExercise'
import TapAllCorrectExercise from './exercises/TapAllCorrectExercise'

const STARTING_HEARTS = 3
const BONUS_XP = 50

interface Props {
  lessonId: string
  onComplete: (lessonId: string, xpEarned: number) => void
  onExit: () => void
}

type FeedbackState = {
  correct: boolean
  explanation: string
}

export default function LessonView({ lessonId, onComplete, onExit }: Props) {
  const lesson = allLessons.find((l) => l.id === lessonId)!

  const [index, setIndex] = useState(0)
  const [hearts, setHearts] = useState(STARTING_HEARTS)
  const [perfectRun, setPerfectRun] = useState(true)
  const [feedback, setFeedback] = useState<FeedbackState | null>(null)
  const [isComplete, setIsComplete] = useState(false)
  const [xpEarned, setXpEarned] = useState(0)
  const [outOfHearts, setOutOfHearts] = useState(false)

  // Per-exercise answer state
  const [selectedMC, setSelectedMC] = useState<number | null>(null)
  const [fillValue, setFillValue] = useState('')
  const [selectedTAC, setSelectedTAC] = useState<Set<number>>(new Set())

  const exercise = lesson.exercises[index]
  const kind = exercise.kind

  const resetAnswerState = useCallback(() => {
    setSelectedMC(null)
    setFillValue('')
    setSelectedTAC(new Set())
  }, [])

  function hasAnswer(): boolean {
    if (kind.type === 'multipleChoice') return selectedMC !== null
    if (kind.type === 'fillInBlank') return fillValue.trim().length > 0
    if (kind.type === 'tapAllCorrect') return selectedTAC.size > 0
    return false
  }

  function checkAnswer(): { correct: boolean; explanation: string } {
    if (kind.type === 'multipleChoice') {
      return {
        correct: selectedMC === kind.correctIndex,
        explanation: kind.explanation,
      }
    }
    if (kind.type === 'fillInBlank') {
      return {
        correct: fillValue.trim() === kind.answer,
        explanation: `The correct answer is: \`${kind.answer}\``,
      }
    }
    if (kind.type === 'tapAllCorrect') {
      const correctSet = new Set(kind.correctIndices)
      const correct =
        selectedTAC.size === correctSet.size &&
        [...selectedTAC].every((i) => correctSet.has(i))
      return { correct, explanation: kind.explanation }
    }
    return { correct: false, explanation: '' }
  }

  function handleCheck() {
    const result = checkAnswer()
    setFeedback(result)
    if (!result.correct) {
      setPerfectRun(false)
      const newHearts = hearts - 1
      setHearts(newHearts)
      if (newHearts <= 0) {
        setOutOfHearts(true)
      }
    }
  }

  function handleContinue() {
    if (outOfHearts) return
    setFeedback(null)
    const nextIndex = index + 1
    if (nextIndex >= lesson.exercises.length) {
      const earned = lesson.xpReward + (perfectRun ? BONUS_XP : 0)
      setXpEarned(earned)
      setIsComplete(true)
    } else {
      setIndex(nextIndex)
      resetAnswerState()
    }
  }

  function handleRestart() {
    setIndex(0)
    setHearts(STARTING_HEARTS)
    setPerfectRun(true)
    setFeedback(null)
    setIsComplete(false)
    setOutOfHearts(false)
    resetAnswerState()
  }

  const progress = (index / lesson.exercises.length) * 100

  // --- Lesson Complete Screen ---
  if (isComplete) {
    return (
      <div className="flex flex-col h-full bg-slate-950 text-slate-100 items-center justify-center px-6 gap-8">
        <div className="text-8xl">🎉</div>
        <div className="text-center flex flex-col gap-2">
          <h2 className="text-3xl font-bold text-white">Lesson Complete!</h2>
          <p className="text-slate-400 text-lg">{lesson.title}</p>
        </div>
        <div className="flex gap-6">
          <div className="flex flex-col items-center gap-1">
            <span className="text-3xl font-bold text-yellow-400">+{xpEarned}</span>
            <span className="text-slate-400 text-sm">XP Earned</span>
          </div>
          {perfectRun && (
            <div className="flex flex-col items-center gap-1">
              <span className="text-3xl">✨</span>
              <span className="text-slate-400 text-sm">Perfect!</span>
            </div>
          )}
          <div className="flex flex-col items-center gap-1">
            <span className="text-3xl">{hearts > 0 ? '❤️'.repeat(hearts) : '💔'}</span>
            <span className="text-slate-400 text-sm">Hearts left</span>
          </div>
        </div>
        <button
          onClick={() => onComplete(lessonId, xpEarned)}
          className="w-full max-w-sm bg-violet-600 active:bg-violet-700 text-white font-bold py-4 rounded-2xl text-lg transition-colors"
        >
          Continue
        </button>
      </div>
    )
  }

  // --- Out of Hearts Screen ---
  if (outOfHearts && feedback) {
    return (
      <div className="flex flex-col h-full bg-slate-950 text-slate-100 items-center justify-center px-6 gap-8">
        <div className="text-8xl">💔</div>
        <div className="text-center flex flex-col gap-2">
          <h2 className="text-3xl font-bold text-white">Out of Hearts!</h2>
          <p className="text-slate-400 text-lg">Don't worry — practice makes perfect.</p>
        </div>
        <div className="flex flex-col gap-3 w-full max-w-sm">
          <button
            onClick={handleRestart}
            className="w-full bg-violet-600 active:bg-violet-700 text-white font-bold py-4 rounded-2xl text-lg transition-colors"
          >
            Try Again
          </button>
          <button
            onClick={onExit}
            className="w-full border-2 border-slate-700 text-slate-300 font-bold py-4 rounded-2xl text-lg transition-colors active:bg-slate-800"
          >
            Back to Home
          </button>
        </div>
      </div>
    )
  }

  // --- Exercise Screen ---
  return (
    <div className="flex flex-col h-full bg-slate-950">
      {/* Top bar */}
      <div className="flex items-center gap-3 px-4 pt-4 pb-2">
        <button
          onClick={onExit}
          className="text-slate-400 active:text-slate-200 text-2xl font-light leading-none"
        >
          ✕
        </button>
        <div className="flex-1 h-3 bg-slate-800 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-violet-600 to-violet-400 rounded-full transition-all duration-300"
            style={{ width: `${progress}%` }}
          />
        </div>
        <div className="flex items-center gap-0.5">
          {Array.from({ length: STARTING_HEARTS }).map((_, i) => (
            <span key={i} className={`text-lg ${i < hearts ? 'opacity-100' : 'opacity-20'}`}>
              ❤️
            </span>
          ))}
        </div>
      </div>

      {/* Exercise content */}
      <div className="flex-1 overflow-y-auto px-4 pt-4 pb-4">
        <ExerciseDispatch
          kind={kind}
          selectedMC={selectedMC}
          onSelectMC={setSelectedMC}
          fillValue={fillValue}
          onChangeFill={setFillValue}
          selectedTAC={selectedTAC}
          onToggleTAC={(i) =>
            setSelectedTAC((prev) => {
              const next = new Set(prev)
              next.has(i) ? next.delete(i) : next.add(i)
              return next
            })
          }
          disabled={feedback !== null}
          showResult={feedback !== null}
          isCorrect={feedback?.correct ?? false}
        />
      </div>

      {/* Bottom action */}
      <div className="px-4 pb-safe flex flex-col gap-2">
        {feedback ? (
          <>
            <div
              className={`rounded-2xl px-4 py-3 ${
                feedback.correct ? 'bg-green-900/50 border border-green-700' : 'bg-red-900/50 border border-red-700'
              }`}
            >
              <p className={`font-bold mb-1 ${feedback.correct ? 'text-green-300' : 'text-red-300'}`}>
                {feedback.correct ? '✓ Correct!' : '✗ Incorrect'}
              </p>
              <p className="text-slate-300 text-sm">
                <InlineCode text={feedback.explanation} />
              </p>
            </div>
            <button
              onClick={handleContinue}
              className={`w-full font-bold py-4 rounded-2xl text-lg transition-colors ${
                feedback.correct
                  ? 'bg-green-600 active:bg-green-700 text-white'
                  : 'bg-red-700 active:bg-red-800 text-white'
              }`}
            >
              Continue
            </button>
          </>
        ) : (
          <button
            disabled={!hasAnswer()}
            onClick={handleCheck}
            className={`w-full font-bold py-4 rounded-2xl text-lg transition-all ${
              hasAnswer()
                ? 'bg-violet-600 active:bg-violet-700 text-white'
                : 'bg-slate-800 text-slate-600 cursor-not-allowed'
            }`}
          >
            Check
          </button>
        )}
      </div>
    </div>
  )
}

interface DispatchProps {
  kind: ExerciseKind
  selectedMC: number | null
  onSelectMC: (i: number) => void
  fillValue: string
  onChangeFill: (v: string) => void
  selectedTAC: Set<number>
  onToggleTAC: (i: number) => void
  disabled: boolean
  showResult: boolean
  isCorrect: boolean
}

function ExerciseDispatch({
  kind,
  selectedMC,
  onSelectMC,
  fillValue,
  onChangeFill,
  selectedTAC,
  onToggleTAC,
  disabled,
  showResult,
  isCorrect,
}: DispatchProps) {
  if (kind.type === 'multipleChoice') {
    return (
      <MultipleChoiceExercise
        data={kind}
        selectedIndex={selectedMC}
        onSelect={onSelectMC}
        disabled={disabled}
        showResult={showResult}
      />
    )
  }
  if (kind.type === 'fillInBlank') {
    return (
      <FillInBlankExercise
        data={kind}
        value={fillValue}
        onChange={onChangeFill}
        disabled={disabled}
        showResult={showResult}
        isCorrect={isCorrect}
      />
    )
  }
  return (
    <TapAllCorrectExercise
      data={kind}
      selectedIndices={selectedTAC}
      onToggle={onToggleTAC}
      disabled={disabled}
      showResult={showResult}
    />
  )
}

function InlineCode({ text }: { text: string }) {
  const parts = text.split(/(`[^`]+`)/)
  return (
    <>
      {parts.map((part, i) =>
        part.startsWith('`') && part.endsWith('`') ? (
          <code key={i} className="font-mono bg-slate-700 px-1 py-0.5 rounded text-violet-300 text-sm">
            {part.slice(1, -1)}
          </code>
        ) : (
          <span key={i}>{part}</span>
        ),
      )}
    </>
  )
}
