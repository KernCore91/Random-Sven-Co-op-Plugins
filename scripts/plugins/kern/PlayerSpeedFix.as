//KernCore's Fix for the Use Speed Fix (Might be imprecise)
//Usage:
/*
	"plugin"
	{
		"name"      	"Player Use Speed Fix"
		"script"    	"kern/PlayerSpeedFix"
	}
*/
//Author: KernCore

void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "KernCore" );
	g_Module.ScriptInfo.SetContactInfo( "https://discord.gg/0wtJ6aAd7XOGI6vI" );
}

void MapInit()
{
	g_Hooks.RegisterHook( Hooks::Player::PlayerPreThink, @PlayerUseFix::PlayerUse );
}

namespace PlayerUseFix
{

HookReturnCode PlayerUse( CBasePlayer@ pPlayer, uint& out uiFlags )
{
	if( pPlayer is null )
		return HOOK_CONTINUE;

	if( pPlayer.pev.flags & FL_ONGROUND != 0 && (pPlayer.m_afButtonLast & IN_USE != 0 || pPlayer.m_afButtonPressed & IN_USE != 0) )
	{
		pPlayer.pev.velocity = pPlayer.pev.velocity * 0.9;
		pPlayer.SetMaxSpeedOverride( 12 );
	}
	else if( pPlayer.m_afButtonReleased & IN_USE != 0 )
	{
		pPlayer.SetMaxSpeedOverride( -1 );
	}

	return HOOK_CONTINUE;
}

}