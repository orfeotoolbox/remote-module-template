#include "otbWrapperApplication.h"
#include "otbWrapperApplicationFactory.h"

class otbEmptyApp : public otb::Wrapper::Application
{
public:
  typedef otbEmptyApp Self;
  typedef itk::SmartPointer<Self> Pointer; 

  itkNewMacro(Self);
  itkTypeMacro(otbEmptyApp, otb::Application);
private:
  void DoInit()
  {
    SetName("otbEmptyApp");
    SetDescription("Empty application.");
  }

  void DoUpdateParameters()
  {
  }

  void DoExecute()
  {  
    int ThisDoesNothing = 0;   
  }
};

OTB_APPLICATION_EXPORT(otbEmptyApp)
