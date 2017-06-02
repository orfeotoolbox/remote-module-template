#include "otbWrapperApplication.h"
#include "otbWrapperApplicationFactory.h"

class EmptyApp : public otb::Wrapper::Application
{
public:
  typedef EmptyApp Self;
  typedef itk::SmartPointer<Self> Pointer; 

  itkNewMacro(Self);
  itkTypeMacro(EmptyApp, otb::Wrapper::Application);
private:
  void DoInit()
  {
    SetName("EmptyApp");
    SetDescription("Empty application.");
  }

  void DoUpdateParameters()
  {
  }

  void DoExecute()
  {  
    int ThisDoesNothing = 0;

    //Silent ununed variable warning
    (void) ThisDoesNothing;
  }
};

OTB_APPLICATION_EXPORT(EmptyApp)
