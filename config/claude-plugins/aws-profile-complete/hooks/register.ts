import type { Register } from 'claude-code'
import { fuzzy, parseList } from './profiles'

const TRIGGER = ';A'

export const register: Register = on => {
  let profiles: string[] | undefined

  on('prompt.autocomplete', { token: /^;A/ }, async ($, e, next) => {
    const base = await next(e)
    profiles ??= parseList((await $.env.get('AWS_PROFILE_COMPLETE_LIST')) ?? '')
    const q = e.token.slice(TRIGGER.length)
    const rows = profiles
      .filter(p => fuzzy(q, p))
      .map(p => ({ text: `AWS_PROFILE=${p}`, label: p, description: 'AWS_PROFILE' }))
    return { suggestions: [...base.suggestions, ...rows] }
  })
}
