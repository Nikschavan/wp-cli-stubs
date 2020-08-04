<?php

return \StubsGenerator\Finder::create()
    ->in('source/vendor/wp-cli/*/src')
    ->notPath('tests')
    ->notPath('CommandNamespace')
    ->notPath('WP_Export_Oxymel.php')
    ->notPath('BlockExtractor.php')
    ->notPath('JedGenerator.php')
    ->sortByName()
;
