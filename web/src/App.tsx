import { useState, useEffect } from 'react'
import type { UserProgress } from './types'
import { loadProgress, saveProgress, completeLesson } from './progress'
import Onboarding from './components/Onboarding'
import Home from './components/Home'
import LessonView from './components/LessonView'
import StatsView from './components/StatsView'

type Screen = 'onboarding' | 'home' | 'lesson' | 'stats'

export default function App() {
  const [progress, setProgress] = useState<UserProgress>(() => loadProgress())
  const [screen, setScreen] = useState<Screen>(() =>
    loadProgress().onboardingDone ? 'home' : 'onboarding',
  )
  const [activeLessonId, setActiveLessonId] = useState<string | null>(null)

  useEffect(() => {
    saveProgress(progress)
  }, [progress])

  function handleOnboardingDone() {
    setProgress((p) => ({ ...p, onboardingDone: true }))
    setScreen('home')
  }

  function handleStartLesson(lessonId: string) {
    setActiveLessonId(lessonId)
    setScreen('lesson')
  }

  function handleLessonComplete(lessonId: string, xpEarned: number) {
    setProgress((p) => completeLesson(p, lessonId, xpEarned))
    setScreen('home')
    setActiveLessonId(null)
  }

  function handleLessonExit() {
    setScreen('home')
    setActiveLessonId(null)
  }

  if (screen === 'onboarding') {
    return <Onboarding onDone={handleOnboardingDone} />
  }

  if (screen === 'lesson' && activeLessonId) {
    return (
      <LessonView
        lessonId={activeLessonId}
        onComplete={handleLessonComplete}
        onExit={handleLessonExit}
      />
    )
  }

  return (
    <div className="flex flex-col h-full bg-slate-950">
      <div className="flex-1 overflow-hidden">
        {screen === 'home' && (
          <Home
            progress={progress}
            onStartLesson={handleStartLesson}
          />
        )}
        {screen === 'stats' && <StatsView progress={progress} />}
      </div>

      {/* Bottom nav */}
      <nav className="flex border-t border-slate-800 bg-slate-950">
        <button
          onClick={() => setScreen('home')}
          className={`flex-1 flex flex-col items-center gap-0.5 py-3 text-xs font-medium transition-colors ${
            screen === 'home' ? 'text-violet-400' : 'text-slate-500'
          }`}
        >
          <span className="text-xl">🏠</span>
          <span>Home</span>
        </button>
        <button
          onClick={() => setScreen('stats')}
          className={`flex-1 flex flex-col items-center gap-0.5 py-3 text-xs font-medium transition-colors ${
            screen === 'stats' ? 'text-violet-400' : 'text-slate-500'
          }`}
        >
          <span className="text-xl">📊</span>
          <span>Progress</span>
        </button>
      </nav>
    </div>
  )
}
