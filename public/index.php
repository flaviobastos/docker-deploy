<?php
$uptime = shell_exec("cat /proc/uptime");
$uptime_seconds = (int)explode(" ", $uptime)[0];
?>

<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Uptime</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-300 flex items-center justify-center h-screen">

    <div class="max-w-fit bg-white rounded-2xl shadow-lg p-6 text-center">
        <h2 class="text-2xl font-bold text-gray-900 uppercase">O servidor está online há:</h2>
        <p id="uptime" class="text-gray-600 mt-2"></p>
    </div>

    <script>
        let uptime = <?php echo $uptime_seconds; ?>;

        function updateUptime() {
            let days = Math.floor(uptime / 86400);
            let hours = Math.floor((uptime % 86400) / 3600);
            let minutes = Math.floor((uptime % 3600) / 60);
            let seconds = uptime % 60;

            document.getElementById("uptime").innerHTML =
                `${days} dias, ${hours} horas, ${minutes} minutos e ${seconds} segundos.`;

            uptime++;
        }

        setInterval(updateUptime, 1000);
        updateUptime();
    </script>

</body>

</html>