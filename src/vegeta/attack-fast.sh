echo "GET http://memes.waymark.se/memes/random?heavy=true" | vegeta attack -duration=5m -rate=16 | tee results.bin | vegeta report
  vegeta report -type=json results.bin > metrics.json
  cat results.bin | vegeta plot > plot.html
  cat results.bin | vegeta report -type="hist[0,100ms,200ms,300ms]"