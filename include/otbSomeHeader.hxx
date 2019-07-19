#ifndef otbSomeHeader_hxx
#define otbSomeHeader_hxx

namespace otb
{

template <class T>
void
SomeTemplatedClass<T>::SetValue(const T &val)
{
  m_Value = val;
}

template <class T>
T
SomeTemplatedClass<T>::GetValue(void)
{
  return m_Value;
}

}

#include "otbSomeHeader.hxx"

#endif
