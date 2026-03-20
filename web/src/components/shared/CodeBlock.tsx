interface Props {
  code: string
  inline?: boolean
}

export function CodeBlock({ code, inline = false }: Props) {
  if (inline) {
    return <span className="font-mono text-sm text-violet-300">{code}</span>
  }
  return (
    <div className="bg-slate-900 rounded-xl p-4 overflow-x-auto">
      <pre className="font-mono text-sm text-slate-200 whitespace-pre">{code}</pre>
    </div>
  )
}
