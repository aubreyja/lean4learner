import type { UserProgress } from '../types'
import { course, allLessons, isUnlocked } from '../data'

interface Props {
  progress: UserProgress
  onStartLesson: (lessonId: string) => void
}

export default function Home({ progress, onStartLesson }: Props) {
  const completedSet = new Set(progress.completedLessonIDs)
  const flatLessons = allLessons

  return (
    <div className="flex flex-col h-full bg-slate-950 overflow-y-auto">
      {/* Header */}
      <div className="sticky top-0 z-10 bg-slate-950 border-b border-slate-800 px-4 py-3">
        <div className="flex items-center justify-between">
          <span className="font-bold text-white text-lg">Learn Lean 4</span>
          <div className="flex items-center gap-4">
            <div className="flex items-center gap-1 text-sm font-semibold text-orange-400">
              <span>🔥</span>
              <span>{progress.currentStreak}</span>
            </div>
            <div className="flex items-center gap-1 text-sm font-semibold text-yellow-400">
              <span>⭐</span>
              <span>{progress.totalXP}</span>
            </div>
          </div>
        </div>
      </div>

      {/* Units */}
      <div className="flex flex-col gap-6 p-4 pb-8">
        {course.units.map((unit) => (
          <div key={unit.id} className="flex flex-col gap-3">
            {/* Unit header */}
            <div className={`bg-gradient-to-r ${unit.colorClass} rounded-2xl px-4 py-3 flex items-center gap-3`}>
              <span className="text-2xl">{unit.emoji}</span>
              <span className="font-bold text-white text-base">{unit.title}</span>
            </div>

            {/* Lessons */}
            {unit.lessons.map((lesson) => {
              const flatIdx = flatLessons.findIndex((l) => l.id === lesson.id)
              const unlocked = isUnlocked(flatIdx, completedSet)
              const completed = completedSet.has(lesson.id)

              return (
                <button
                  key={lesson.id}
                  disabled={!unlocked}
                  onClick={() => onStartLesson(lesson.id)}
                  className={`flex items-center justify-between px-4 py-3.5 rounded-2xl border-2 transition-all text-left ${
                    !unlocked
                      ? 'border-slate-800 bg-slate-900 opacity-50 cursor-not-allowed'
                      : completed
                      ? 'border-green-700 bg-green-900/30 active:bg-green-900/50'
                      : 'border-violet-700 bg-violet-900/20 active:bg-violet-900/40'
                  }`}
                >
                  <div className="flex items-center gap-3">
                    <span className="text-xl">
                      {!unlocked ? '🔒' : completed ? '✅' : '📖'}
                    </span>
                    <div className="flex flex-col">
                      <span className={`font-semibold text-sm ${!unlocked ? 'text-slate-500' : 'text-slate-100'}`}>
                        {lesson.title}
                      </span>
                      <span className="text-xs text-slate-500">+{lesson.xpReward} XP</span>
                    </div>
                  </div>
                  {unlocked && !completed && (
                    <span className="text-violet-400 text-lg">›</span>
                  )}
                </button>
              )
            })}
          </div>
        ))}
      </div>
    </div>
  )
}
