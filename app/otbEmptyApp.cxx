#include "otbWrapperApplication.h"
#include "otbWrapperApplicationFactory.h"

#include "otbSomeHeader.h"
#include "otbSomeFile.h"

class EmptyApp : public otb::Wrapper::Application
{
public:
  typedef EmptyApp Self;
  typedef itk::SmartPointer<Self> Pointer; 

  itkNewMacro(Self);
  itkTypeMacro(EmptyApp, otb::Wrapper::Application);
private:
  void DoInit() override
  {
    SetName("EmptyApp");
    SetDescription("Empty application.");
  }

  void DoUpdateParameters() override
  {
  }

  void DoExecute() override
  {  
    int ThisDoesNothing = 0;
    
    otb::SomeTemplatedClass<double> a;
    a.SetValue(2.0);
    double v = a.GetValue();

    otbAppLogINFO("This application does nothing : "<< v);

    otb::ThisFunctionDoesNothing();

    //Silent ununed variable warning
    (void) ThisDoesNothing;
  }
};

OTB_APPLICATION_EXPORT(EmptyApp)
