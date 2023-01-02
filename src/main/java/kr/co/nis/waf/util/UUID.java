// 
// Decompiled by Procyon v0.6.0
// 

package kr.co.nis.waf.util;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.security.NoSuchAlgorithmException;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.io.Serializable;

public final class UUID implements Serializable
{
    private static final long serialVersionUID = -4856846361193249489L;
    private final long mostSigBits;
    private final long leastSigBits;
    private transient int version;
    private transient int variant;
    private transient volatile long timestamp;
    private transient int sequence;
    private transient long node;
    private transient int hashCode;
    private static volatile SecureRandom numberGenerator;
    
    private UUID(final byte[] data) {
        this.version = -1;
        this.variant = -1;
        this.timestamp = -1L;
        this.sequence = -1;
        this.node = -1L;
        this.hashCode = -1;
        long msb = 0L;
        long lsb = 0L;
        for (int i = 0; i < 8; ++i) {
            msb = (msb << 8 | (long)(data[i] & 0xFF));
        }
        for (int i = 8; i < 16; ++i) {
            lsb = (lsb << 8 | (long)(data[i] & 0xFF));
        }
        this.mostSigBits = msb;
        this.leastSigBits = lsb;
    }
    
    public UUID(final long mostSigBits, final long leastSigBits) {
        this.version = -1;
        this.variant = -1;
        this.timestamp = -1L;
        this.sequence = -1;
        this.node = -1L;
        this.hashCode = -1;
        this.mostSigBits = mostSigBits;
        this.leastSigBits = leastSigBits;
    }
    
    public static UUID randomUUID() {
        SecureRandom ng = UUID.numberGenerator;
        if (ng == null) {
            ng = (UUID.numberGenerator = new SecureRandom());
        }
        final byte[] randomBytes = new byte[16];
        ng.nextBytes(randomBytes);
        final byte[] array = randomBytes;
        final int n = 6;
        array[n] &= 0xF;
        final byte[] array2 = randomBytes;
        final int n2 = 6;
        array2[n2] |= 0x40;
        final byte[] array3 = randomBytes;
        final int n3 = 8;
        array3[n3] &= 0x3F;
        final byte[] array4 = randomBytes;
        final int n4 = 8;
        array4[n4] |= (byte)128;
        return new UUID(randomBytes);
    }
    
    public static UUID nameUUIDFromBytes(final byte[] name) {
        MessageDigest md;
        try {
            md = MessageDigest.getInstance("MD5");
        }
        catch (final NoSuchAlgorithmException nsae) {
            throw new InternalError("MD5 not supported");
        }
        final byte[] digest;
        final byte[] md5Bytes = digest = md.digest(name);
        final int n = 6;
        digest[n] &= 0xF;
        final byte[] array = md5Bytes;
        final int n2 = 6;
        array[n2] |= 0x30;
        final byte[] array2 = md5Bytes;
        final int n3 = 8;
        array2[n3] &= 0x3F;
        final byte[] array3 = md5Bytes;
        final int n4 = 8;
        array3[n4] |= (byte)128;
        return new UUID(md5Bytes);
    }
    
    public static UUID fromString(final String name) {
        final String[] components = name.split("-");
        if (components.length != 5) {
            throw new IllegalArgumentException("Invalid UUID string: " + name);
        }
        for (int i = 0; i < 5; ++i) {
            components[i] = "0x" + components[i];
        }
        long mostSigBits = Long.decode(components[0]);
        mostSigBits <<= 16;
        mostSigBits |= Long.decode(components[1]);
        mostSigBits <<= 16;
        mostSigBits |= Long.decode(components[2]);
        long leastSigBits = Long.decode(components[3]);
        leastSigBits <<= 48;
        leastSigBits |= Long.decode(components[4]);
        return new UUID(mostSigBits, leastSigBits);
    }
    
    public long getLeastSignificantBits() {
        return this.leastSigBits;
    }
    
    public long getMostSignificantBits() {
        return this.mostSigBits;
    }
    
    public int version() {
        if (this.version < 0) {
            this.version = (int)(this.mostSigBits >> 12 & 0xFL);
        }
        return this.version;
    }
    
    public int variant() {
        if (this.variant < 0) {
            if (this.leastSigBits >>> 63 == 0L) {
                this.variant = 0;
            }
            else if (this.leastSigBits >>> 62 == 2L) {
                this.variant = 2;
            }
            else {
                this.variant = (int)(this.leastSigBits >>> 61);
            }
        }
        return this.variant;
    }
    
    public long timestamp() {
        if (this.version() != 1) {
            throw new UnsupportedOperationException("Not a time-based UUID");
        }
        long result = this.timestamp;
        if (result < 0L) {
            result = (this.mostSigBits & 0xFFFL) << 48;
            result |= (this.mostSigBits >> 16 & 0xFFFFL) << 32;
            result |= this.mostSigBits >>> 32;
            this.timestamp = result;
        }
        return result;
    }
    
    public int clockSequence() {
        if (this.version() != 1) {
            throw new UnsupportedOperationException("Not a time-based UUID");
        }
        if (this.sequence < 0) {
            this.sequence = (int)((this.leastSigBits & 0x3FFF000000000000L) >>> 48);
        }
        return this.sequence;
    }
    
    public long node() {
        if (this.version() != 1) {
            throw new UnsupportedOperationException("Not a time-based UUID");
        }
        if (this.node < 0L) {
            this.node = (this.leastSigBits & 0xFFFFFFFFFFFFL);
        }
        return this.node;
    }
    
    @Override
    public String toString() {
        return digits(this.mostSigBits >> 32, 8) + "-" + digits(this.mostSigBits >> 16, 4) + "-" + digits(this.mostSigBits, 4) + "-" + digits(this.leastSigBits >> 48, 4) + "-" + digits(this.leastSigBits, 12);
    }
    
    private static String digits(final long val, final int digits) {
        final long hi = 1L << digits * 4;
        return Long.toHexString(hi | (val & hi - 1L)).substring(1);
    }
    
    @Override
    public int hashCode() {
        if (this.hashCode == -1) {
            this.hashCode = (int)(this.mostSigBits >> 32 ^ this.mostSigBits ^ this.leastSigBits >> 32 ^ this.leastSigBits);
        }
        return this.hashCode;
    }
    
    @Override
    public boolean equals(final Object obj) {
        if (!(obj instanceof UUID)) {
            return false;
        }
        if (((UUID)obj).variant() != this.variant()) {
            return false;
        }
        final UUID id = (UUID)obj;
        return this.mostSigBits == id.mostSigBits && this.leastSigBits == id.leastSigBits;
    }
    
    public int compareTo(final UUID val) {
        return (this.mostSigBits < val.mostSigBits) ? -1 : ((this.mostSigBits > val.mostSigBits) ? 1 : ((this.leastSigBits < val.leastSigBits) ? -1 : ((this.leastSigBits > val.leastSigBits) ? 1 : 0)));
    }
    
    private void readObject(final ObjectInputStream in) throws IOException, ClassNotFoundException {
        in.defaultReadObject();
        this.version = -1;
        this.variant = -1;
        this.timestamp = -1L;
        this.sequence = -1;
        this.node = -1L;
        this.hashCode = -1;
    }
    
    static {
        UUID.numberGenerator = null;
    }
}
