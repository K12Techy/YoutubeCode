Add-Type -AssemblyName PresentationFramework
[xml]$Form  = @"
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="Google User Report" Height="450" Width="800">
    <Grid>
    <Label Content="User Email" Margin="73,37,600,0" FontWeight="Bold"/>
        <TextBox Name="UserEmal" HorizontalAlignment="Right" Height="23" Margin="10,38,300,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="300">
            <TextBox.Effect>
                <DropShadowEffect/>
            </TextBox.Effect>
        </TextBox>
        
        <Rectangle Fill="#FFC7C7E0" HorizontalAlignment="Left" Height="279" Margin="73,103,0,0" Stroke="Black" VerticalAlignment="Top" Width="658"/>
        <Label Content="Last Sign in " HorizontalAlignment="Left" Margin="91,124,0,0" VerticalAlignment="Top"  FontWeight="Bold"/>
        <TextBlock Name="LastLogon" HorizontalAlignment="Left" Margin="174,124,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Height="26" Width="235" Background="#FFE8E8E8">
            <TextBlock.Effect>
                <DropShadowEffect/>
            </TextBlock.Effect>
        </TextBlock>
        <Label Content="Org Unit" HorizontalAlignment="Left" Margin="91,174,0,0" VerticalAlignment="Top"  FontWeight="Bold"/>
        <TextBlock Name="OU" HorizontalAlignment="Left" Margin="174,174,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Height="26" Width="235" Background="#FFE8E8E8">
            <TextBlock.Effect>
                <DropShadowEffect/>
            </TextBlock.Effect>
        </TextBlock>
        <Label Content="Account Suspended" HorizontalAlignment="Left" Margin="91,221,0,0" VerticalAlignment="Top"  FontWeight="Bold"/>
        <CheckBox Name="Suspended" Content="" HorizontalAlignment="Left" Margin="237,227,0,0" VerticalAlignment="Top" RenderTransformOrigin="0.349,2.073" Height="20" Width="20" IsEnabled="False"/>
        <Label Content="Must Change Password" HorizontalAlignment="Left" Margin="91,252,0,0" VerticalAlignment="Top" FontWeight="Bold"/>
        <CheckBox Name="Password" Content="" HorizontalAlignment="Left" Margin="237,258,0,0" VerticalAlignment="Top" RenderTransformOrigin="0.349,2.073" Height="20" Width="20" IsEnabled="False"/>
        <TextBlock Name="Groups" HorizontalAlignment="Left" Height="207" Margin="455,161,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="237" Background="#FFE8E8E8">
            <TextBlock.Effect>
                <DropShadowEffect/>
            </TextBlock.Effect>
        </TextBlock>
        <Label Content="Groups" HorizontalAlignment="Left" Margin="455,126,0,0" VerticalAlignment="Top"  FontWeight="Bold"/>
        <Button Name="Submit" Content="Submit" HorizontalAlignment="Left" Margin="190,78,0,0" VerticalAlignment="Top" Width="75" RenderTransformOrigin="1.799,1.425"/>

    </Grid>
</Window>

"@


$NR=(New-Object System.Xml.XmlNodeReader $Form)
$Win=[Windows.Markup.XamlReader]::Load( $NR )
$Submit = $Win.FindName(“Submit”)



$Submit.Add_Click({
$username = $Win.FindName("UserEmal").Text
$User = (Gam info user $userName)
$Groups = @()
[datetime]$LastLogin = ($user|Select-String -Pattern "Last login time:").Tostring().Split(' ')[3]
$OU = ($user|Select-String -Pattern "Google Org Unit Path:").Tostring().Split(':').TrimStart(' ')[1]
 if(($user|Select-String -Pattern "Account Suspended:").Tostring().Split(':').TrimStart(' ')[1]-eq 'True'){$Suspended =$true} else{ $Suspended =$false}
$GroupTextString = ($user|select-string -Pattern "Groups:")
$Groupsindex = ($User.indexof($GroupTextString))+1

While($User[$Groupsindex].ToString()[0]-eq ' '){
    $Groups += ($User[$Groupsindex].ToString().TrimStart(' ').split('<')[0]) 
    $Groupsindex+=1
} 

 if(($user|Select-String -Pattern "Must Change Password:").Tostring().Split(':').TrimStart(' ')[1]-eq 'True'){$password = $true} else{ $password= $false}
$Win.FindName("OU").Text = $OU
$Win.FindName("LastLogon").Text= $LastLogin.ToString()
$Win.FindName("Password").IsChecked = $password
$Win.FindName("Suspended").IsChecked = $Suspended
$Win.FindName("Groups").Text = $Groups
})
$Win.showdialog()