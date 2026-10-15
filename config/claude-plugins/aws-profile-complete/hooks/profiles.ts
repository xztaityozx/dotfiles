// カンマ区切りのプロファイル一覧。前後の空白と空要素は無視
export const parseList = (text: string): string[] =>
  text
    .split(',')
    .map(l => l.trim())
    .filter(l => l !== '')

// fzf 風: クエリの文字が順に含まれていればマッチ(大文字小文字無視)
export const fuzzy = (query: string, target: string): boolean => {
  const t = target.toLowerCase()
  let i = 0
  for (const c of query.toLowerCase()) {
    i = t.indexOf(c, i)
    if (i < 0) return false
    i++
  }
  return true
}
