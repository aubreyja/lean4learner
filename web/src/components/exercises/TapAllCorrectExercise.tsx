import type { TapAllCorrectKind } from '../../types'
import { CodeBlock } from '../shared/CodeBlock'

interface Props {
  data: TapAllCorrectKind
  selectedIndices: Set<number>
  onToggle: (i: number) => void
  disabled: boolean
  showResult: boolean
}

export default function TapAllCorrectExercise({
  data,
  selectedIndices,
  onToggle,
  disabled,
  showResult,
}: Props) {
  const correctSet = new Set(data.correctIndices)

  return (
    <div className="flex flex-col gap-4">
      <p className="text-slate-100 text-lg leading-snug">
        <InlineCode text={data.question} />
      </p>
      <p className="text-slate-400 text-sm">Select all that apply</p>

      <div className="grid grid-cols-2 gap-2">
        {data.options.map((option, i) => {
          const isSelected = selectedIndices.has(i)
          const isCorrect = correctSet.has(i)

          let style =
            'border-2 rounded-xl px-3 py-3 text-sm font-mono font-medium transition-all text-center '

          if (!showResult) {
            style += isSelected
              ? 'border-violet-500 bg-violet-500/20 text-violet-200'
              : 'border-slate-700 bg-slate-800 text-slate-200 active:border-slate-500'
          } else {
            if (isCorrect) {
              style += 'border-green-500 bg-green-500/20 text-green-200'
            } else if (isSelected && !isCorrect) {
              style += 'border-red-500 bg-red-500/20 text-red-200'
            } else {
              style += 'border-slate-700 bg-slate-800 text-slate-500'
            }
          }

          return (
            <button
              key={i}
              disabled={disabled}
              onClick={() => onToggle(i)}
              className={style}
            >
              <CodeBlock code={option} inline />
            </button>
          )
        })}
      </div>
    </div>
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
