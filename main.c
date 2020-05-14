#include <pspkernel.h>
#include <pspdebug.h>

#include <chicken.h>

#define PROGNAME "ChickenDemo"

PSP_MODULE_INFO(PROGNAME, 0, 1, 1);
PSP_MAIN_THREAD_ATTR(THREAD_ATTR_USER | THREAD_ATTR_VFPU);

/* Exit callback */
int exit_callback(int arg1, int arg2, void *common)
{
	sceKernelExitGame();
	return 0;
}

/* Callback thread */
int CallbackThread(SceSize args, void *argp)
{
	int cbid;

	cbid = sceKernelCreateCallback("Exit Callback", exit_callback, NULL);
	sceKernelRegisterExitCallback(cbid);

	sceKernelSleepThreadCB();

	return 0;
}

/* Sets up the callback thread and returns its thread id */
int SetupCallbacks(void)
{
	int thid = 0;

	thid = sceKernelCreateThread("update_thread", CallbackThread, 0x11, 0xFA0, 0, 0);
	if(thid >= 0)
	{
		sceKernelStartThread(thid, 0, 0);
	}

	return thid;
}


int main(int argc, char *argv[]) {
	SetupCallbacks();
	pspDebugScreenInit();
	// pspDebugInstallErrorHandler crashes on my PSP
	//...

	CHICKEN_run(C_toplevel);

	sceKernelExitDeleteThread(0);
	return 0;
}
