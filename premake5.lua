workspace "Octopus"
	architecture "x64"
	startproject "sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "Octopus/vendor/GLFW/include"

include "Octopus/vendor/GLFW"

project "Octopus"
	location "Octopus"
	kind "StaticLib"
	language "C++"
	cppdialect "C++20"
	staticruntime "on"
	buildoptions{"/utf-8"}

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "ocpch.h"
	pchsource "Octopus/src/ocpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}"
	}

	links
	{
		"GLFW",
		"opengl32.lib"
	}

	filter "system:windows"
		systemversion "latest"
	
	filter "configurations:Debug"
		defines
		{
			"OC_DEBUG",
			"ENABLE_ASSERTS"
		}
		symbols "On"

	filter "configurations:Release"
		defines "OC_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "OC_DIST"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++20"
	staticruntime "on"
	buildoptions{"/utf-8"}

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Octopus/src",
		"Octopus/vendor/spdlog/include",
		"%{IncludeDir.GLFW}"
	}

	links
	{
		"Octopus"
	}

	filter "system:windows"
		systemversion "latest"
	
	filter "configurations:Debug"
		defines
		{
			"OC_DEBUG",
			"ENABLE_ASSERTS"
		}
		symbols "On"

	filter "configurations:Release"
		defines "OC_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "OC_DIST"
		optimize "On"