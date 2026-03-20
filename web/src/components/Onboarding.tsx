import { useState } from 'react'

interface Props {
  onDone: () => void
}

const slides = [
  {
    emoji: '🧮',
    title: 'Learn Lean 4',
    body: 'Master Lean 4 — a powerful proof assistant and functional programming language — through bite-sized interactive lessons.',
  },
  {
    emoji: '⭐',
    title: 'Earn XP & Streaks',
    body: 'Complete lessons to earn XP, maintain daily streaks, and track your progress from beginner to tactics expert.',
  },
  {
    emoji: '❤️',
    title: 'Three Lives Per Lesson',
    body: 'You have 3 hearts per lesson. Wrong answers cost a heart — but you can always try again. Perfect runs earn bonus XP!',
  },
]

export default function Onboarding({ onDone }: Props) {
  const [index, setIndex] = useState(0)
  const slide = slides[index]
  const isLast = index === slides.length - 1

  return (
    <div className="flex flex-col h-full bg-slate-950 text-slate-100">
      <div className="flex-1 flex flex-col items-center justify-center px-8 gap-8">
        <div className="text-8xl">{slide.emoji}</div>
        <div className="text-center flex flex-col gap-3">
          <h1 className="text-3xl font-bold text-white">{slide.title}</h1>
          <p className="text-slate-400 text-lg leading-relaxed">{slide.body}</p>
        </div>

        {/* Dots */}
        <div className="flex gap-2">
          {slides.map((_, i) => (
            <button
              key={i}
              onClick={() => setIndex(i)}
              className={`w-2 h-2 rounded-full transition-all ${
                i === index ? 'bg-violet-500 w-6' : 'bg-slate-600'
              }`}
            />
          ))}
        </div>
      </div>

      <div className="px-6 pb-safe">
        <button
          onClick={() => (isLast ? onDone() : setIndex((i) => i + 1))}
          className="w-full bg-violet-600 active:bg-violet-700 text-white font-bold py-4 rounded-2xl text-lg transition-colors"
        >
          {isLast ? 'Get Started' : 'Next'}
        </button>
      </div>
    </div>
  )
}
