#pragma once

#include "base.h"

#include "Window.h"
#include "Octopus/LayerStack.h"
#include "events/Event.h"
#include "Octopus/Events/ApplicationEvent.h"

namespace Octopus {

	class Application
	{
	private:
		std::unique_ptr<Window> m_Window;
		bool m_Running = true;
		LayerStack m_LayerStack;

		bool OnWindowClose(WindowCloseEvent& e);
	public:
		Application(const WindowProps& props = WindowProps());
		virtual ~Application();
		
		void Run();

		void OnEvent(Event& e);

		void PushLayer(Layer* layer) { m_LayerStack.PushLayer(layer); }
		void PushOverlay(Layer* overlay) { m_LayerStack.PushOverlay(overlay); }
	};

	// Define in client.
	Application* CreateApplication();
}
