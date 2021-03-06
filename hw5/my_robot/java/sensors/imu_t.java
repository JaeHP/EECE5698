/* LCM type definition class file
 * This file was automatically generated by lcm-gen
 * DO NOT MODIFY BY HAND!!!!
 */

package sensors;
 
import java.io.*;
import java.util.*;
import lcm.lcm.*;
 
public final class imu_t implements lcm.lcm.LCMEncodable
{
    public double yaw;
    public double pitch;
    public double roll;
    public double mag_x;
    public double mag_y;
    public double mag_z;
    public double accel_x;
    public double accel_y;
    public double accel_z;
    public double gyro_x;
    public double gyro_y;
    public double gyro_z;
 
    public imu_t()
    {
    }
 
    public static final long LCM_FINGERPRINT;
    public static final long LCM_FINGERPRINT_BASE = 0x37ce410a961cd173L;
 
    static {
        LCM_FINGERPRINT = _hashRecursive(new ArrayList<Class<?>>());
    }
 
    public static long _hashRecursive(ArrayList<Class<?>> classes)
    {
        if (classes.contains(sensors.imu_t.class))
            return 0L;
 
        classes.add(sensors.imu_t.class);
        long hash = LCM_FINGERPRINT_BASE
            ;
        classes.remove(classes.size() - 1);
        return (hash<<1) + ((hash>>63)&1);
    }
 
    public void encode(DataOutput outs) throws IOException
    {
        outs.writeLong(LCM_FINGERPRINT);
        _encodeRecursive(outs);
    }
 
    public void _encodeRecursive(DataOutput outs) throws IOException
    {
        outs.writeDouble(this.yaw); 
 
        outs.writeDouble(this.pitch); 
 
        outs.writeDouble(this.roll); 
 
        outs.writeDouble(this.mag_x); 
 
        outs.writeDouble(this.mag_y); 
 
        outs.writeDouble(this.mag_z); 
 
        outs.writeDouble(this.accel_x); 
 
        outs.writeDouble(this.accel_y); 
 
        outs.writeDouble(this.accel_z); 
 
        outs.writeDouble(this.gyro_x); 
 
        outs.writeDouble(this.gyro_y); 
 
        outs.writeDouble(this.gyro_z); 
 
    }
 
    public imu_t(byte[] data) throws IOException
    {
        this(new LCMDataInputStream(data));
    }
 
    public imu_t(DataInput ins) throws IOException
    {
        if (ins.readLong() != LCM_FINGERPRINT)
            throw new IOException("LCM Decode error: bad fingerprint");
 
        _decodeRecursive(ins);
    }
 
    public static sensors.imu_t _decodeRecursiveFactory(DataInput ins) throws IOException
    {
        sensors.imu_t o = new sensors.imu_t();
        o._decodeRecursive(ins);
        return o;
    }
 
    public void _decodeRecursive(DataInput ins) throws IOException
    {
        this.yaw = ins.readDouble();
 
        this.pitch = ins.readDouble();
 
        this.roll = ins.readDouble();
 
        this.mag_x = ins.readDouble();
 
        this.mag_y = ins.readDouble();
 
        this.mag_z = ins.readDouble();
 
        this.accel_x = ins.readDouble();
 
        this.accel_y = ins.readDouble();
 
        this.accel_z = ins.readDouble();
 
        this.gyro_x = ins.readDouble();
 
        this.gyro_y = ins.readDouble();
 
        this.gyro_z = ins.readDouble();
 
    }
 
    public sensors.imu_t copy()
    {
        sensors.imu_t outobj = new sensors.imu_t();
        outobj.yaw = this.yaw;
 
        outobj.pitch = this.pitch;
 
        outobj.roll = this.roll;
 
        outobj.mag_x = this.mag_x;
 
        outobj.mag_y = this.mag_y;
 
        outobj.mag_z = this.mag_z;
 
        outobj.accel_x = this.accel_x;
 
        outobj.accel_y = this.accel_y;
 
        outobj.accel_z = this.accel_z;
 
        outobj.gyro_x = this.gyro_x;
 
        outobj.gyro_y = this.gyro_y;
 
        outobj.gyro_z = this.gyro_z;
 
        return outobj;
    }
 
}

