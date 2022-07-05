# Defined in - @ line 1
function git-delete-local-not-remote --wraps=git\ branch\ -vv\ \|\ grep\ \':\ gone\]\'\|\ \ grep\ -v\ \*\ \|\ awk\ \'\{\ print\ \;\ \}\'\ \|\ xargs\ -r\ git\ branch\ -D --description alias\ git-delete-local-not-remote=git\ branch\ -vv\ \|\ grep\ \':\ gone\]\'\|\ \ grep\ -v\ \*\ \|\ awk\ \'\{\ print\ \;\ \}\'\ \|\ xargs\ -r\ git\ branch\ -D
  git branch -vv | grep ': gone]'|  grep -v * | awk '{ print ; }' | xargs -r git branch -D $argv;
end
