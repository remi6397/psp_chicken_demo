;;;; psp.scm -- Sony PSP-specific functionalities
;
; To the extent possible under law, the person who associated CC0 with
; this project has waived all copyright and related or neighboring rights
; to this project.
;
; You should have received a copy of the CC0 legalcode along with this
; work.  If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

(import
	scheme
	chicken.platform
	chicken.foreign)

#>

#include <pspkernel.h>
#include <pspdebug.h>

<#

(define psp/debug-screen-init
	(foreign-lambda void "pspDebugScreenInit"))

(define psp/debug-screen-printf
	(foreign-lambda void "pspDebugScreenPrintf" c-string))
