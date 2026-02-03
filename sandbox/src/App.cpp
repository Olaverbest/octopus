#include <Octopus.h>

class ExampleLayer : public Octopus::Layer
{
	public:
	ExampleLayer()
		: Layer("Example") {}

	void OnUpdate() override
	{
		OC_INFO("ExampleLayer::OnUpdate");
	}

	void OnEvent(Octopus::Event& event) override
	{
		OC_INFO("ExampleLayer::OnEvent: {0}", event);
	}
};

class Sandbox : public Octopus::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
	}
	
	~Sandbox()
	{
	}
};

Octopus::Application* Octopus::CreateApplication()
{
	return new Sandbox();
}