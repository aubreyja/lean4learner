import type { UserProgress } from '../types'
import { allLessons } from '../data'

interface Props {
  progress: UserProgress
}

export default function StatsView({ progress }: Props) {
  const totalLessons = allLessons.length

  const stats = [
    { emoji: '🔥', label: 'Day Streak', value: String(progress.currentStreak) },
    { emoji: '⭐', label: 'Total XP', value: String(progress.totalXP) },
    { emoji: '✅', label: 'Lessons Completed', value: `${progress.totalLessonsCompleted} / ${totalLessons}` },
    {
      emoji: '📅',
      label: 'Last Active',
      value: progress.lastActivityDate
        ? new Date(progress.lastActivityDate).toLocaleDateString(undefined, {
            month: 'short',
            day: 'numeric',
            year: 'numeric',
          })
        : 'Never',
    },
  ]

  const pct = Math.round((progress.totalLessonsCompleted / totalLessons) * 100)

  return (
    <div className="flex flex-col h-full bg-slate-950 overflow-y-auto">
      <div className="sticky top-0 z-10 bg-slate-950 border-b border-slate-800 px-4 py-3">
        <span className="font-bold text-white text-lg">Your Progress</span>
      </div>

      <div className="flex flex-col gap-4 p-4">
        {/* Overall progress bar */}
        <div className="bg-slate-900 rounded-2xl p-4 flex flex-col gap-3">
          <div className="flex justify-between items-center">
            <span className="text-slate-300 font-semibold">Course Progress</span>
            <span className="text-violet-400 font-bold">{pct}%</span>
          </div>
          <div className="h-3 bg-slate-800 rounded-full overflow-hidden">
            <div
              className="h-full bg-gradient-to-r from-violet-600 to-violet-400 rounded-full transition-all duration-500"
              style={{ width: `${pct}%` }}
            />
          </div>
          <p className="text-slate-500 text-sm">
            {progress.totalLessonsCompleted} of {totalLessons} lessons completed
          </p>
        </div>

        {/* Stat cards */}
        {stats.map((s) => (
          <div key={s.label} className="bg-slate-900 rounded-2xl px-4 py-4 flex items-center gap-4">
            <span className="text-3xl">{s.emoji}</span>
            <div className="flex flex-col">
              <span className="text-slate-400 text-xs">{s.label}</span>
              <span className="text-white text-xl font-bold">{s.value}</span>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
