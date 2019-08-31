#requires -Version 2 -Modules posh-git, Pansies

function Write-Theme {
    param (
        [bool] $lastCommandFailed,
        [string] $with
    )
    
    $segmentSeparator=[char]::ConvertFromUtf32(0xE0B0)
    $pathSegmentSeparator=[char]::ConvertFromUtf32(0xE0B1)
    $pathBackGround="#323232"

    # path
    $path=$(Get-Location).Path
    # actual prompt
    [System.Collections.Generic.List[PoshCode.Pansies.Text]]$box=@{}
    if($path.StartsWith($HOME)) {
        $box.Add(([PoshCode.Pansies.Text]@{Object=" ~ "; Foreground="#E0E0E0"; Background="#1565C0"}))
        $box.Add(([PoshCode.Pansies.Text]@{Object=$segmentSeparator; Foreground="#1565C0";Background=$pathBackGround}))
        $path = $path.Replace($HOME,"")
    }

    $split=$path.Split("\", [System.StringSplitOptions]::RemoveEmptyEntries)

    if($split.Count -ge 2) {
        (
            ($split[0]),
            ($split[0], [char]::ConvertFromUtf32(0x2026))
        )[$split.Length -gt 2] | ForEach-Object {
            $box.Add(([PoshCode.Pansies.Text]@{
                Object= ' ' +  $_ + ' ';
                Background=$pathBackGround;
                Foreground="#E0E0E0"
            }))
            $box.Add(([PoshCode.Pansies.Text]@{
                Object = $pathSegmentSeparator
                Background=$pathBackGround;
                Foreground="#626262"
            }))
        }   
    }
    $box.Add(([PoshCode.Pansies.Text]@{
        Object = ' ' + $split[$split.Length-1] + ' ' ;
        Background=$pathBackGround;
        Foreground="#AB47BC"
    }))

    # vcsStatus
    $status = Get-VCSStatus
    if(![string]::IsNullOrEmpty($status)) {
        # {branchName} > {index} > {aheadBy} > {working} > {conflict} > {stash}
        $stashCount=((git stash list)|Measure-Object).Count
        $hasStash = $stashCount -ne 0
        $stashBack = "#3949AB"
        $conflictCount=((git status -s)|Where-Object {"$_".StartsWith("UU")}|Measure-Object).Count
        $hasConflict = $conflictCount -ne 0
        $conflictBack = "#EF5350"
        $hasIndex = $status.HasIndex -and !$hasConflict
        $hasWorking = $status.HasWorking -and !$hasConflict
        $isClean = !$hasIndex -and !$hasWorking -and !$hasConflict
        $working = $status.Working
        $index   = $status.Index
        $branchBack = ("#CDDC39","#212121")[!$isClean]
        $branchFore = ("#424242","#E0E0E0")[!$isClean]
        $indexBack  = "#33691E"
        $workingBack = "#212121"
        $workingFore = "#FBC02D"
        $aheadBy = $status.AheadBy
        $hasAheadBy = $aheadBy -ne 0
        $aheadByBack = "#9E9E9E"
        $black=[System.ConsoleColor]::Black


        # separator
        $box.Add(([PoshCode.Pansies.Text]@{
            Object = $segmentSeparator; Foreground=$pathBackGround; Background=$branchBack
        }))

        # branch
        $box.Add([PoshCode.Pansies.Text]@{
            Object = [char]::ConvertFromUtf32(0xe0a0); Foreground=("#212121", "#CDDC39")[!$isClean]; Background=$branchBack
        })
        $box.Add([PoshCode.Pansies.Text]@{Object=' ' + $status.Branch + ' '; Foreground=$branchFore; Background=$branchBack})
        $box.Add([PoshCode.Pansies.Text]@{
            Object     = if ($isClean -or $hasAheadBy -or $hasIndex) {
                $segmentSeparator
            } else {
                $pathSegmentSeparator
            };
            Foreground = if($isClean -or $hasIndex -or $hasAheadBy){
                $branchBack
            } else {
                "#626262"
            };
            Background = if($isClean) {
                if($hasAheadBy) {
                    $aheadByBack
                } elseif($hasStash) {
                    $stashBack
                } else {
                    $black
                }
            } elseif($hasIndex) {
                $indexBack
            } elseif($hasAheadBy){
                $aheadByBack
            } else {
                $branchBack
            }
        })

        # has index
        if($hasIndex) {
            $box.Add([PoshCode.Pansies.Text]@{
                Object = ' ' + $index.Length + [char]::ConvertFromUtf32(0x2714) + ' ';
                Foreground = "#E0E0E0"
            })
            $box.Add([PoshCode.Pansies.Text]@{
                Object = $segmentSeparator;
                Foreground = $indexBack;
                Background = if ($hasAheadBy) {
                    $aheadByBack
                } elseif($hasWorking) {
                    $workingBack
                } elseif($hasConflict) {
                    $conflictCount
                } else {
                    $black
                }
            })
        }

        # has AheadBy
        if($aheadBy -ne 0) {
            $box.Add([PoshCode.Pansies.Text]@{
                Object = ' ' + $aheadBy + [char]::ConvertFromUtf32(0x2b06) + ' '
                Foreground = "#F5F5F5";
                Background = $aheadByBack;
            })
            $box.Add([PoshCode.Pansies.Text]@{
                Object = $segmentSeparator;
                Foreground = $aheadByBack;
                Background = if($isClean) {
                    $black
                } elseif($hasWorking) {
                    $workingBack
                } elseif($hasStash){
                    $stashBack
                } else {
                    $conflictBack
                }
            })
        }

        # has working
        if($hasWorking) {
            $box.Add([PoshCode.Pansies.Text]@{
                Object = ' ' + $working.Length + '+' + ' ';
                Foreground = $workingFore;
                Background = $workingBack;
            })
            $box.Add([PoshCode.Pansies.Text]@{
                Object = $segmentSeparator;
                Foreground = $workingBack;
                Background = if($hasConflict) {
                    $aheadByBack
                } elseif($hasStash){
                    $stashBack
                } else {
                    $black
                }
            })
        }

        # has conflict 
        if($hasConflict) {
            $box.Add([PoshCode.Pansies.Text]@{
                Object = ' ' + $conflictCount + [char]::ConvertFromUtf32(0x273c) + ' '
                Foreground = "#E0E0E0"
                Background = $conflictBack
            })
            $box.Add([PoshCode.Pansies.Text]@{
                Object = $segmentSeparator
                Foreground = $conflictBack
                Background = if($hasStash) {
                    $stashBack
                } else {
                    $black
                }
            })
        }

        # has stash
        if($hasStash) {
            $box.Add([PoshCode.Pansies.Text]@{
                Object = ' ' + $stashCount + [char]::ConvertFromUtf32(0x2691) + ' '
                Foreground = "#E0E0E0"
                Background = $stashBack
            })
            $box.Add([PoshCode.Pansies.Text]@{
                Object = $segmentSeparator
                Foreground = $stashBack
                Background = $black
            })
        }

    } else {
        $box.Add(([PoshCode.Pansies.Text]@{
            Object = $segmentSeparator;
            Foreground=$pathBackGround;
            Background=[System.ConsoleColor]::Black
        }))
    }

    $prompt=""
    $box | ForEach-Object {$prompt += Write-Prompt -Object $_}

    # newline
    $prompt += Set-Newline

    # user prompt
    $userBack = "#4A148C"
    $lastBack = ("#212121","#B71C1C")[$lastCommandFailed]
    (
        [PoshCode.Pansies.Text]@{Object = ' ' + $env:USERNAME + ' ';Foreground = "#E0E0E0";Background = $userBack},
        [PoshCode.Pansies.Text]@{Object = $segmentSeparator;Foreground = $userBack;Background = $lastBack},
        [PoshCode.Pansies.Text]@{Object = ' % '; Foreground="#E0E0E0";Background=$lastBack},
        [PoshCode.Pansies.Text]@{Object = $segmentSeparator;Foreground = $lastBack; Background = [System.ConsoleColor]::Black},
        [PoshCode.Pansies.Text]@{Object = ''; Foreground = [ConsoleColor]::White}
    ) | ForEach-Object {$prompt += Write-Prompt -Object $_}

    $prompt += ' '
    $prompt
}

$True