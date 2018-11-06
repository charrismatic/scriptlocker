#!/bin/sh

# =============================================================================
#  MATT HARRIS
#  m@ttHarri.is
#  11/14/2017, 12:01:19 PM
# =============================================================================
# SCRIPTLOCKER - HANDLES YOUR EXECUTION FOR YOUR SCRIPTS. STORES THEM AND
# GETS THEM CALLS THEM FROM ANY PATH.
# DYNAMIC SCRIPT LOADER AND MANAGER
# HELPS YOU WRITE SMALL SCRIPTS AND CALL THEM FROM ANYWHERE
# WITH PATHS AND ENV SET CORRECTLY

# SET THIS IN THE EQUIVALNET .ENV TO PROVIDE A CONFIGURATION FILE OUTSDIE OF THE THE CODE
if [ -z $SCRIPTLOCKER ]; then
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



_script_loader () {
  # INCLDUE_SCRIPTS_IN_PATH=
  # DEFAULTS TO FALSE, SINCE MANY OF THE SCRIPTS HERE ARE MEANT TO BE RUN ONE TIME
  # OR DO SOEMTHING SPECIFIC ENOUGH THAT WE DO NOT WANT OT EXECUTE THEM ACCIDENTALLY. 
  # The /bin folder is already added to the path. Scripts here are meant be stored outside the default
  # path since they are accessed through a scpecial command. 
  
  # Default 
  ENABLE_SCRIPTLOCKER=true
  ENABLE_SCRIPTLOCKER_LOADER=true
  if [ -z $ENABLE_SCRIPTLOCKER ]; then
    echo "scriptloader is not enabled. Set ENABLE_SCRIPTLOCKER=true in your environment file"
    return
  fi

  SCRIPT_NAME=${1-list}
  SCRIPT_ARGS=${2:-}

  SCRIPTLOCKER_PATH="$LIB0_SHELLPATH/scripts"
  SCRIPTLOCKER=false

  if [ -z $SCRIPT_NAME ]; then
    echo "sh $SCRIPTLOCKER_PATH/$SCRIPT_NAME $SCRIPT_ARGS"
    sh $SCRIPTLOCKER_PATH/$SCRIPT_NAME $SCRIPT_ARGS
  fi

}
