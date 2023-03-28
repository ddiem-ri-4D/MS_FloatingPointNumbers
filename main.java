
import java.io.*;
import java.math.BigInteger;

public class A {
    public static void main(String[] args) throws Exception {
        BufferedWriter bufferedWriter = getBufferWriter("./double/java.txt");
        BigInteger a = new BigInteger("2");
        a = a.pow(53);
        BigInteger b = new BigInteger("2").pow(54);
        System.out.printf("a = %d\n", a);
        System.out.printf("b = %d\n", b);

        long startTime = System.nanoTime();
        BigInteger n = new BigInteger("0");
        BigInteger one = new BigInteger("1");
        BigInteger one_h = new BigInteger("100");

        for (BigInteger c  = a; c.compareTo(b)<=0; c.add(one)) {
            bufferedWriter.write(String.format("c = %08d => %8.1f\n", c, c.doubleValue()));
            bufferedWriter.flush();
            System.out.println(c);

            if (n == (BigInteger)((c.subtract(a)).multiply(one_h).divide(a))){
              n.add(one);
              System.out.printf(String.format("%d/100\n", n));
            }
        }
        long stopTime = System.nanoTime();

        System.out.println((stopTime - startTime)/1000000);
        bufferedWriter.flush();
        bufferedWriter.close();
    }




    private static BufferedWriter getBufferWriter(String fileName) throws IOException {
        File file = new File(fileName);
        if (file.exists()) {
            RandomAccessFile raf = new RandomAccessFile(file, "rw");
            raf.setLength(0);
            raf.close();
        }
        return new BufferedWriter(new FileWriter(file, true));
    }
}