function mvn-new --description "create new empty maven project"
    # 交互式提示输入各个参数
    read -P "Enter groupId: " groupId
    read -P "Enter artifactId: " artifactId

    set mvn_cmd "mvn archetype:generate -DgroupId=$groupId -DartifactId=$artifactId -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false"
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