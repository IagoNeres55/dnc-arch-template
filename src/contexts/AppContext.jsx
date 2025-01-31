import React from "react";
import { createContext, useState, useEffect } from "react"
import { webtect } from "../mocks/webtext";

export const AppContext = createContext()

export const AppProvider = ({ children }) => {
  const savedLanguage = localStorage.getItem('lang')
  const [language, setLanguage] = useState(savedLanguage ?? 'br')
  const [languages, setLanguages] = useState(webtect)
  const [loading, setLoading] = useState(false)

  // useEffect(() => {
  //       const fetchLanguages = async () => {
  //           try {
  //               const getTexts = await getApiData('webtext')
  //               setLanguages(getTexts)
  //           } catch (e) {
  //               console.error(e)
  //           }
  //           finally {
  //             setLoading(false)
  //           }
  //       }

  //       fetchLanguages()
  // }, [])

  useEffect(() => {
    localStorage.setItem('lang', language)
  }, [language])

  return (
    <AppContext.Provider value={{ languages, language, setLanguage, loading }}>
      {children}
    </AppContext.Provider>
  )
}

