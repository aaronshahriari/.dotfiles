#!/usr/bin/env zsh

COMMANDS=("apex" "query" "manifest" "deploy" "retrieve" "test")
selected_command=$(printf "%s\n" "${COMMANDS[@]}" | fzf --prompt="Select command: ")

[[ -z "$selected_command" ]] && echo "No command selected. Exiting."

# default: assume we need a file
needs_file=true

case "$selected_command" in
    apex)     
        ext=".apex"
        run="sf apex run -f"
        ;;
    query)
        ext=".soql"
        run="sf data query -f"
        ;;
    manifest)
        ext=".xml"
        run="sf project deploy start -x"
        ;;
    deploy)
        ext=".cls"
        run="sf project deploy start -d"
        ;;
    retrieve)
        run="sf project retrieve start --metadata ApexClass:"
        needs_file=false
        ;;
    test)
        ext="_Test.cls"
        run="sf apex run test --code-coverage --synchronous --class-names "
        ;;
    *)
        echo "Unknown command"
        exit 1
        ;;
esac

if $needs_file; then
    files=$(find . -type f -name "*${ext}" -not -path "*/\.*")
    selected_file=$(printf "%s\n" "$files" | fzf --prompt="Select ${ext} file: ")

    [[ -z "$selected_file" ]] && echo "No file selected. Exiting."

    print -z "$run $selected_file"
else
    print -z "$run"
fi
