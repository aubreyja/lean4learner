export type MultipleChoiceKind = {
  type: 'multipleChoice'
  question: string
  codeSnippet?: string
  options: string[]
  correctIndex: number
  explanation: string
}

export type FillInBlankKind = {
  type: 'fillInBlank'
  instruction: string
  codePrefix: string
  codeSuffix: string
  answer: string
  hint: string
}

export type TapAllCorrectKind = {
  type: 'tapAllCorrect'
  question: string
  options: string[]
  correctIndices: number[]
  explanation: string
}

export type ExerciseKind = MultipleChoiceKind | FillInBlankKind | TapAllCorrectKind

export interface Exercise {
  id: string
  kind: ExerciseKind
}

export interface Lesson {
  id: string
  title: string
  xpReward: number
  exercises: Exercise[]
}

export interface Unit {
  id: string
  title: string
  emoji: string
  colorClass: string   // Tailwind bg gradient classes
  lessons: Lesson[]
}

export interface Course {
  title: string
  tagline: string
  units: Unit[]
}

export interface UserProgress {
  totalXP: number
  completedLessonIDs: string[]
  currentStreak: number
  lastActivityDate: string | null  // ISO date string YYYY-MM-DD
  totalLessonsCompleted: number
  onboardingDone: boolean
}
