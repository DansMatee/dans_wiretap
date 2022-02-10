# dans_wiretap
 
Hello guys, today I present to you a procrastination project, a police scanner for phone calls.
I want to preface this by saying the UI is NOT good at all. This was a project to start learning how to interact with js and pma-voice. I may update this in the future to give it a proper UI, but feel free to replace the UI with something of your choice!

How it works:
1. Get all players in a certain area, and check if they are currently on a call channel.
2. Once we recieve all call channels, the scanner will be updated to allow the user to select any channel they see.
3. The player is then connected into the channel they select for a set amount of time, before having to rescan and reconnect.

This is a brief overview, but its pretty simple after looking over the code.

There are helper commands for locally testing. These are currently commented out, but to enable them just uncomment and restart the resource.

Pre Requisites:
- PMA-Voice
- Mythic_Notify (This can be changed very easy)
