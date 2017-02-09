"""LCM type definitions
This file automatically generated by lcm.
DO NOT MODIFY BY HAND!!!!
"""

try:
    import cStringIO.StringIO as BytesIO
except ImportError:
    from io import BytesIO
import struct

class gpsdata(object):
    __slots__ = ["timestamp", "latitude", "longitude", "altitude", "utm_x", "utm_y"]

    def __init__(self):
        self.timestamp = ""
        self.latitude = 0.0
        self.longitude = 0.0
        self.altitude = 0.0
        self.utm_x = 0.0
        self.utm_y = 0.0

    def encode(self):
        buf = BytesIO()
        buf.write(gpsdata._get_packed_fingerprint())
        self._encode_one(buf)
        return buf.getvalue()

    def _encode_one(self, buf):
        __timestamp_encoded = self.timestamp.encode('utf-8')
        buf.write(struct.pack('>I', len(__timestamp_encoded)+1))
        buf.write(__timestamp_encoded)
        buf.write(b"\0")
        buf.write(struct.pack(">ddddd", self.latitude, self.longitude, self.altitude, self.utm_x, self.utm_y))

    def decode(data):
        if hasattr(data, 'read'):
            buf = data
        else:
            buf = BytesIO(data)
        if buf.read(8) != gpsdata._get_packed_fingerprint():
            raise ValueError("Decode error")
        return gpsdata._decode_one(buf)
    decode = staticmethod(decode)

    def _decode_one(buf):
        self = gpsdata()
        __timestamp_len = struct.unpack('>I', buf.read(4))[0]
        self.timestamp = buf.read(__timestamp_len)[:-1].decode('utf-8', 'replace')
        self.latitude, self.longitude, self.altitude, self.utm_x, self.utm_y = struct.unpack(">ddddd", buf.read(40))
        return self
    _decode_one = staticmethod(_decode_one)

    _hash = None
    def _get_hash_recursive(parents):
        if gpsdata in parents: return 0
        tmphash = (0x3b55d1e23c7f40ea) & 0xffffffffffffffff
        tmphash  = (((tmphash<<1)&0xffffffffffffffff)  + (tmphash>>63)) & 0xffffffffffffffff
        return tmphash
    _get_hash_recursive = staticmethod(_get_hash_recursive)
    _packed_fingerprint = None

    def _get_packed_fingerprint():
        if gpsdata._packed_fingerprint is None:
            gpsdata._packed_fingerprint = struct.pack(">Q", gpsdata._get_hash_recursive([]))
        return gpsdata._packed_fingerprint
    _get_packed_fingerprint = staticmethod(_get_packed_fingerprint)
