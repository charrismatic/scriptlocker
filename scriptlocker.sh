#!/bin/sh

# =============================================================================
#  MATT HARRIS
#  m@ttHarri.is
#  11/14/2017, 12:01:19 PM
# =============================================================================
# "SCRIPT LOCKER" - HANDLES YOUR EXECUTION FOR YOUR SCRIPTS. STORES THEM AND
# GETS THEM CALLS THEM FROM ANY PATH.
# DYNAMIC SCRIPT LOADER AND MANAGER
# HELPS YOU WRITE SMALL SCRIPTS AND CALL THEM FROM ANYWHERE
# WITH PATHS AND ENV SET CORRECTLY

# SET THIS IN THE EQUIVALNET .ENV TO PROVIDE A CONFIGURATION FILE OUTSDIE OF THE THE CODE
if [ -z $SCRIPTLOADER ]; then
  return
fi

_scripts_info () {
    echo "  --list                  - LIST ALL SCRIPTS"
    echo "  --explore               - OPEN FOLDER IN FILE MANAGER"
    echo "  --interactive           - INTERACTIVE LIST MENU TO SELECT (LAUNCHER MENU)"
    echo "  --goto-scripts          - CHANGE DIRECTORY TO THE SCRIPT FOLDER"
    echo "  --install [file]        - MOVES SCRIPT IN LOCAL PATH TO SCRIPTS FOLDER AND FIXES FILE PERMISSION"
    echo "  --dryrun [script]       - HOW OUTPUT BEFORE RUNNING"
    echo "  --script-show [script]] - DUMP SCRIPT CONTENTS TO PAGER WITH HIGHLIGHTING"
    echo "  --script-help [script]] - SHOW SHOW OPTIONS"
    echo "  --script-edit [script]] - EDIT SCRIPT"
}

_script_list () {
  SCRIPTS_PATH="$LIB0_ROOT/scripts"
  ls $SCRIPTS_PATH
}


_script_loader () {
  # INCLDUE_SCRIPTS_IN_PATH=
  # DEFAULTS TO FALSE, SINCE MANY OF THE SCRIPTS HERE ARE MEANT TO BE RUN ONE TIME OR DO SOEMTHING SPECIFIC ENOUGH THAT
  # WE DO NOT WANT OT EXECUTE THEM ACCIDENTALLY. The bin/ folder is already added to the path. Scripts here are meant for
  # more complicated operations.
  ENABLE_LIB0SCRIPTS=true
  ENABLE_LIB0SCRIPT_LOADER=true
  if [ -z $ENABLE_LIB0SCRIPTS ]; then
    echo "Commandctl scriptloader is not enabled. Set ENABLE_LIB0SCRIPTS=true in your environment file"
    return
  fi

  SCRIPT_NAME=${1-list}
  SCRIPT_ARGS=${2:-}

  LIB0_SCRIPTSPATH="$LIB0_ROOT/scripts"
  LIB0_SCRIPT_VERBOSE=false

  if [ -z $SCRIPT_NAME ]; then
    echo "sh $LIB0_SCRIPTSPATH/$SCRIPT_NAME $SCRIPT_ARGS"
    sh $LIB0_SCRIPTSPATH/$SCRIPT_NAME $SCRIPT_ARGS
  fi

}




scriptlocker () {
  ACTION=${1:-help}
  echo "scriptlocker: $ACTION"

  case $ACTION in
     list)
        _script_list
        ;;

     help)
        _script_list
        ;;

    run)
       SELECTION=${2:?The show command requires parameter}
        _script_loader $SELECTION
       ;;

       *)
        _script_list
      ;;
  esac
}

scriptlocker $@
