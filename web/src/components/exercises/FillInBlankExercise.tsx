import { useRef, useEffect } from 'react'
import type { FillInBlankKind } from '../../types'

interface Props {
  data: FillInBlankKind
  value: string
  onChange: (v: string) => void
  disabled: boolean
  showResult: boolean
  isCorrect: boolean
}

export default function FillInBlankExercise({
  data,
  value,
  onChange,
  disabled,
  showResult,
  isCorrect,
}: Props) {
  const inputRef = useRef<HTMLInputElement>(null)

  useEffect(() => {
    if (!disabled) inputRef.current?.focus()
  }, [disabled])

  const inputStyle = showResult
    ? isCorrect
      ? 'border-green-500 bg-green-500/10 text-green-200'
      : 'border-red-500 bg-red-500/10 text-red-200'
    : 'border-violet-500 bg-slate-800 text-slate-100 focus:border-violet-400'

  return (
    <div className="flex flex-col gap-4">
      <p className="text-slate-100 text-lg leading-snug">{data.instruction}</p>

      {/* Code block with inline input */}
      <div className="bg-slate-900 rounded-xl p-4 overflow-x-auto">
        <pre className="font-mono text-sm text-slate-200 whitespace-pre-wrap break-words">
          {data.codePrefix && <span className="text-slate-300">{data.codePrefix}</span>}
          <input
            ref={inputRef}
            type="text"
            value={value}
            onChange={(e) => onChange(e.target.value)}
            disabled={disabled}
            autoCapitalize="none"
            autoCorrect="off"
            autoComplete="off"
            spellCheck={false}
            placeholder="___"
            className={`font-mono text-sm border-b-2 bg-transparent outline-none px-1 min-w-[3rem] w-auto transition-colors ${inputStyle}`}
            style={{ width: `${Math.max(value.length + 1, 4)}ch` }}
          />
          {data.codeSuffix && <span className="text-slate-300">{data.codeSuffix}</span>}
        </pre>
      </div>

      {!showResult && (
        <p className="text-slate-400 text-sm">
          💡 Hint: {data.hint}
        </p>
      )}
    </div>
  )
}
