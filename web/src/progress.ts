import type { UserProgress } from './types'

const KEY = 'lean4learner_progress'

const DEFAULT: UserProgress = {
  totalXP: 0,
  completedLessonIDs: [],
  currentStreak: 0,
  lastActivityDate: null,
  totalLessonsCompleted: 0,
  onboardingDone: false,
}

export function loadProgress(): UserProgress {
  try {
    const raw = localStorage.getItem(KEY)
    if (!raw) return { ...DEFAULT }
    return { ...DEFAULT, ...JSON.parse(raw) }
  } catch {
    return { ...DEFAULT }
  }
}

export function saveProgress(p: UserProgress): void {
  localStorage.setItem(KEY, JSON.stringify(p))
}

function todayISO(): string {
  return new Date().toISOString().slice(0, 10)
}

function daysBetween(a: string, b: string): number {
  return Math.round((Date.parse(b) - Date.parse(a)) / 86_400_000)
}

export function recordActivity(p: UserProgress): UserProgress {
  const today = todayISO()
  if (!p.lastActivityDate) {
    return { ...p, currentStreak: 1, lastActivityDate: today }
  }
  const days = daysBetween(p.lastActivityDate, today)
  if (days === 0) return p
  if (days === 1) return { ...p, currentStreak: p.currentStreak + 1, lastActivityDate: today }
  return { ...p, currentStreak: 1, lastActivityDate: today }
}

export function completeLesson(p: UserProgress, lessonId: string, xp: number): UserProgress {
  const isNew = !p.completedLessonIDs.includes(lessonId)
  const updated = isNew
    ? {
        ...p,
        totalXP: p.totalXP + xp,
        totalLessonsCompleted: p.totalLessonsCompleted + 1,
        completedLessonIDs: [...p.completedLessonIDs, lessonId],
      }
    : p
  return recordActivity(updated)
}
