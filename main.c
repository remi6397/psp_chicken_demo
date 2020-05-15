/* To the extent possible under law, the person who associated CC0 with
 * this project has waived all copyright and related or neighboring rights
 * to this project.
 *
 * You should have received a copy of the CC0 legalcode along with this
 * work.  If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. */

#include <pspkernel.h>
#include <pspdebug.h>

PSP_MODULE_INFO("ChickenDemo", 0, 1, 1);
PSP_MAIN_THREAD_ATTR(THREAD_ATTR_USER | THREAD_ATTR_VFPU);

int done = 0;

int IsDone() { return done; }

/* Exit callback */
int exit_callback(int arg1, int arg2, void *common)
{
  done = 1;
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

#include <chicken.h>

int main(void)
{
  pspDebugScreenInit();
  SetupCallbacks();

  CHICKEN_run(C_toplevel);

  sceKernelExitDeleteThread(0);
  return 0;
}
