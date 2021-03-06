WireToolSetup.setCategory( "Physics" )
WireToolSetup.open( "igniter", "Igniter", "gmod_wire_igniter", nil, "Igniters" )

if CLIENT then
	language.Add( "tool.wire_igniter.name", "Igniter Tool (Wire)" )
	language.Add( "tool.wire_igniter.desc", "Spawns a constant igniter prop for use with the wire system." )
	language.Add( "tool.wire_igniter.0", "Primary: Create/Update Igniter" )
	language.Add( "WireIgniterTool_trgply", "Allow Player Igniting" )
	language.Add( "WireIgniterTool_Range", "Max Range:" )
end
WireToolSetup.BaseLang()
WireToolSetup.SetupMax( 20, TOOL.Mode.."s" , "You've hit the Wire "..TOOL.PluralName.." limit!" )

if SERVER then
	CreateConVar('sbox_wire_igniters_maxlen', 30)
	CreateConVar('sbox_wire_igniters_allowtrgply',1)
	
	function TOOL:GetConVars() 
		return self:GetClientNumber( "trgply" )~=0, self:GetClientNumber("range") 
	end

	function TOOL:MakeEnt( ply, model, Ang, trace )
		return MakeWireIgniter( ply, trace.HitPos, Ang, model, self:GetConVars() )
	end
end

TOOL.ClientConVar = {
	trgply	= 0,
	range	= 2048,
	model	= "models/jaanus/wiretool/wiretool_siren.mdl",
}

function TOOL.BuildCPanel(panel)
	WireToolHelpers.MakePresetControl(panel, "wire_igniter")
	ModelPlug_AddToCPanel(panel, "Laser_Tools", "wire_igniter", true)
	panel:CheckBox("#WireIgniterTool_trgply", "wire_igniter_trgply")
	panel:NumSlider("#WireIgniterTool_Range", "wire_igniter_range", 1, 10000, 0)
end
