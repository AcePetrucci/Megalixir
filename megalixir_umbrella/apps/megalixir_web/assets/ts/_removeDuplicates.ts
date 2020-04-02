export const removeDuplicates = (list: string[], type: 'script' | 'link') => {
  const query = (s: string) => `${type === 'script' ? 'script[src*="' : 'link[href*="'}${s}"]`;

  list.map(s => document.querySelectorAll(query(s)).forEach((node, i) => {
    if (i > 0) { node.remove(); }
  }))
}