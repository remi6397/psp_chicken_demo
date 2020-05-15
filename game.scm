;;;; game.scm -- Demo PSP game in Chicken
;
; To the extent possible under law, the person who associated CC0 with
; this project has waived all copyright and related or neighboring rights
; to this project.
;
; You should have received a copy of the CC0 legalcode along with this
; work.  If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

(declare
  (uses psp))

(import
  scheme
  chicken.platform)

(debug-screen-printf "Hello from CHICKEN Scheme  (\")>\n")

(let loop ()
        (unless (done?)
          (loop)))

(return-to-host)
