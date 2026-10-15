import { test, expect } from 'claude-code/testing'
import { fuzzy, parseList } from './profiles'

test('parseList splits by comma and skips blanks', () => {
  expect(parseList('dev-admin, prod,,stg ')).toEqual(['dev-admin', 'prod', 'stg'])
  expect(parseList('')).toEqual([])
})

test('fuzzy matches subsequences', () => {
  expect(fuzzy('dad', 'dev-admin')).toBe(true)
  expect(fuzzy('', 'prod')).toBe(true)
  expect(fuzzy('xp', 'prod')).toBe(false)
})

