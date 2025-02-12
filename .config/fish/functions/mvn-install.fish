function mvn-install --description "install java package from local file"
    # 交互式提示输入各个参数
    # 如果系统中存在 fzf，则使用 fzf 进行文件选择；否则使用 read 提示
    if type -q fzf
        echo "Select file (fzf supported): "
        # 这里调用 fzf 的文件查找功能（你可以根据需要调整查找范围，比如用 find 命令）
        set file (fzf --prompt "File> " --query "")
        if test -z "$file"
            echo "No file selected!"
            return 1
        end
        echo $file
    else
        read -P "Enter file path: " file
    end
    read -P "Enter groupId: " groupId
    read -P "Enter artifactId: " artifactId
    read -P "Enter version: " pkgVersion
    # 对 packaging 参数提供候选值: jar、war、pom、ear
    set packaging_options jar war pom ear
    if type -q fzf
        echo "Select packaging (jar, war, pom, ear): "
        # 用 fzf 从预设的选项中选择
        set packaging (printf "%s\n" $packaging_options | fzf --prompt "Packaging> ")
        if test -z "$packaging"
            echo "No packaging selected!"
            return 1
        end
    else
        read -P "Enter packaging: " packaging
    end

    set mvn_cmd "mvn install:install-file -Dfile=$file -DgroupId=$groupId -DartifactId=$artifactId -Dversion=$pkgVersion -Dpackaging=$packaging -DgeneratePom=true"

    echo $mvn_cmd

    # 最终确认
    read -P "Execute? (y/N): " confirm
    if test "$confirm" != y -a "$confirm" != Y
        echo "Aborted!"
        return 1
    end

    # 执行 maven 命令
    eval $mvn_cmd
end