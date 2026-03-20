import type { MultipleChoiceKind } from '../../types'
import { CodeBlock } from '../shared/CodeBlock'

interface Props {
  data: MultipleChoiceKind
  selectedIndex: number | null
  onSelect: (i: number) => void
  disabled: boolean
  showResult: boolean
}

export default function MultipleChoiceExercise({
  data,
  selectedIndex,
  onSelect,
  disabled,
  showResult,
}: Props) {
  return (
    <div className="flex flex-col gap-4">
      <p className="text-slate-100 text-lg leading-snug">
        <InlineCode text={data.question} />
      </p>

      {data.codeSnippet && <CodeBlock code={data.codeSnippet} />}

      <div className="flex flex-col gap-2">
        {data.options.map((option, i) => {
          const isSelected = selectedIndex === i
          const isCorrect = i === data.correctIndex

          let style =
            'border-2 rounded-xl px-4 py-3 text-left text-sm font-medium transition-all '

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
              onClick={() => onSelect(i)}
              className={style}
            >
              <InlineCode text={option} />
            </button>
          )
        })}
      </div>
    </div>
  )
}

/** Renders backtick-wrapped spans as monospace inline code. */
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
