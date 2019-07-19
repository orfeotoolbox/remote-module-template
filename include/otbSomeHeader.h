#ifndef otbSomeHeader_h
#define otbSomeHeader_h

namespace otb
{

template <class T>
class SomeTemplatedClass
{
public:
  void SetValue(const T &val);

  T GetValue(void);

private:
  T m_Value;
};

}

#include "otbSomeHeader.hxx"

#endif
