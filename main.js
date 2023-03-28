const fs = require('fs');

function get_buffer_writer(file_name) {
  fs.writeFileSync(file_name, "");
  return fs.createWriteStream(file_name, {flags: 'a'});
}

const buffered_writer = get_buffer_writer("./float/js.txt");
const a = 0b00000001000000000000000000000000; // 2^24
const b = 0b00000010000000000000000000000000; // 2^25
console.log("a = ", a);
console.log("b = ", b);

const start_time = new Date().getTime();
let n = 0;
for (let c = a; c <= b; c++) {
  buffered_writer.write(`c = ${c.toString()} => ${c.toFixed(1)}\n`);

  if (n === parseInt(((c-a)*100/a))) {
    n += 1;
    console.log(`${n}/100\n`);
  }
}
const stop_time = new Date().getTime();

console.log((stop_time - start_time));
buffered_writer.flush();
buffered_writer.close();


