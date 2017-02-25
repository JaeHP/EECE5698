"""LCM type definitions
This file automatically generated by lcm.
DO NOT MODIFY BY HAND!!!!
"""

try:
    import cStringIO.StringIO as BytesIO
except ImportError:
    from io import BytesIO
import struct

class gps_t(object):
    __slots__ = ["time_stamp", "lat", "lon", "alt", "utm_x", "utm_y"]

    def __init__(self):
        self.time_stamp = ""
        self.lat = 0.0
        self.lon = 0.0
        self.alt = 0.0
        self.utm_x = 0.0
        self.utm_y = 0.0

    def encode(self):
        buf = BytesIO()
        buf.write(gps_t._get_packed_fingerprint())
        self._encode_one(buf)
        return buf.getvalue()

    def _encode_one(self, buf):
        __time_stamp_encoded = self.time_stamp.encode('utf-8')
        buf.write(struct.pack('>I', len(__time_stamp_encoded)+1))
        buf.write(__time_stamp_encoded)
        buf.write(b"\0")
        buf.write(struct.pack(">ddddd", self.lat, self.lon, self.alt, self.utm_x, self.utm_y))

    def decode(data):
        if hasattr(data, 'read'):
            buf = data
        else:
            buf = BytesIO(data)
        if buf.read(8) != gps_t._get_packed_fingerprint():
            raise ValueError("Decode error")
        return gps_t._decode_one(buf)
    decode = staticmethod(decode)

    def _decode_one(buf):
        self = gps_t()
        __time_stamp_len = struct.unpack('>I', buf.read(4))[0]
        self.time_stamp = buf.read(__time_stamp_len)[:-1].decode('utf-8', 'replace')
        self.lat, self.lon, self.alt, self.utm_x, self.utm_y = struct.unpack(">ddddd", buf.read(40))
        return self
    _decode_one = staticmethod(_decode_one)

    _hash = None
    def _get_hash_recursive(parents):
        if gps_t in parents: return 0
        tmphash = (0x2a1872b7526a5222) & 0xffffffffffffffff
        tmphash  = (((tmphash<<1)&0xffffffffffffffff)  + (tmphash>>63)) & 0xffffffffffffffff
        return tmphash
    _get_hash_recursive = staticmethod(_get_hash_recursive)
    _packed_fingerprint = None

    def _get_packed_fingerprint():
        if gps_t._packed_fingerprint is None:
            gps_t._packed_fingerprint = struct.pack(">Q", gps_t._get_hash_recursive([]))
        return gps_t._packed_fingerprint
    _get_packed_fingerprint = staticmethod(_get_packed_fingerprint)
