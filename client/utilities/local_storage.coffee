module.exports =
  getItem: (item) -> window.localStorage.getItem(item)
  setItem: (item, value) -> window.localStorage.setItem(item, value)
  removeItem: (item) -> window.localStorage.removeItem(item)