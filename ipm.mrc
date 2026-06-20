; Auto-updating script. Local modifications will be overwritten.

; ipm (IRC Package Manager) by realJoshByrnes

on 1:LOAD:{
  echo $color(info2) -ta * ipm v $+ $ipm.version loaded.
}

on 1:START:{
  echo $color(info2) -ta * ipm v $+ $ipm.version started.
  .signal -n ipm.start -s
}

on 1:signal:ipm.start:{
  $iif($1 == -s, .) $+ ipm.update
}

menu MenuBar {
  ipm
  .Packages
  ..$style(2) Add/Remove:noop
  .-
  .Check for updates:ipm.update
}

alias -l ipm.update.timer .timeripm.update 1 3600 .ipm.update $chr(124) ipm.update.timer
alias -l ipm.version return 1.0.0

; Self updater
alias -l ipm.update {
  ipm.update.timer
  var %target = $qt($script)
  if ($urlget($1-).state) {
    if ($ifmatch == ok) {
      if ($urlget($1-).redirect) {
        ; Follow redirect
        ipm.update $ifmatch
      }
      else {
        if ($regex($urlget($1).reply, /^ETag:[ \t]*(?:W\/)"([^"\r\n]+)"[ \t]*\r?\n/im)) {
          bset -t &header 1 ; ETag: $regml(1) $+ $crlf
        }
        bcopy &header $calc($bvar(&header, 0) + 1) $urlget($1).target 1 -1
        if ($sha1(%target, 2) !== $sha1(&header, 1)) {
          bwrite -c %target 0 &header
          var %bps = $calc(($bvar(&header, 0) / $max($urlget($1).time, 1)) * 1000)
          echo $color(info2) -ta * Update: Downloaded $bytes($bvar(&header, 0), 3).suf to $noqt(%target) $+($chr(40),$bytes(%bps, 3).suf,/s,$chr(41))
          .timer -m 1 1 echo $color(info2) -ta * Update: ipm $eval($unsafe(v $ $+ + $ $+ ipm.version), 2) now installed.
          .reload -rs %target
        }
        else {
          $iif(!$show, .) $+ echo $color(info2) -qta * Update: ipm v $+ $$ipm.version is already the latest version.
        }
      }
    }
    else {
      var %code = $gettok($urlget($1).reply, 2, 32)
      if (%code == 304) {
        $iif(!$show, .) $+ echo $color(info2) -qta * Update: ipm v $+ $$ipm.version is already the latest version.
      }
      else {
        $iif(!$show, .) $+ echo $color(info) -qta * Update: ipm could not be updated $+ $iif(%code, $+($chr(32), $chr(40), HTTP Status $ifmatch, $chr(41))) $+ .
      }
    }
  }
  else {
    var %url = $iif($1-, $ifmatch, https://raw.githubusercontent.com/realJoshByrnes/ipm/refs/heads/main/ipm.mrc)
    if ($bvar(&ipm_headers, 0) > 0) bunset &ipm_headers
    if ($read(%target, nt, 1) && $regex($ifmatch, /^\s*; ETag: (.*)$/i)) {
      bset -t &ipm_headers 1 If-None-Match: " $+ $regml($ifmatch) $+ " $+ $crlf
    }
    noop $urlget(%url, bg, &ipm_body, $iif(!$show,.) $+ ipm.update, $iif($bvar(&ipm_headers), $ifmatch))
    return
    :error
    reseterror
    $iif(!$show, .) $+ echo $color(info) -qta * An error has occured attempting while attempting to update ipm. $iif($error, $+($chr(40), $ifmatch, $chr(41)))
  }
}

; AdiIRC workarounds:
; "/timer 1 0" never triggers, instead we use "/timer -m 1 1" for AdiIRC.
; "/echo -q" doesn't work unless the dot is passed to echo (ie. "/.echo")
