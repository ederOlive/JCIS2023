"""
Embedded Python Blocks:

Each time this file is saved, GRC will instantiate the first class it finds
to get ports and parameters of your block. The arguments to __init__  will
be the parameters. All of them are required to have default values!
"""

import numpy as np
from gnuradio import gr


class blk(gr.sync_block):  # other base classes are basic_block, decim_block, interp_block
    """Embedded Python Block example - a simple multiply const"""

    def __init__(self, vector_size=24, num_bits=3):  # only default arguments here
        """arguments to this function show up as parameters in GRC"""
        # if an attribute with the same name as a parameter is found,
        # a callback is registered (properties work, too).
        self.vector_size = vector_size
        self.num_bits = num_bits
        gr.sync_block.__init__(
            self,
            name='quant_uniform',   # will show up in GRC
            in_sig=[(np.float32, vector_size)],
            out_sig=[(np.float32, vector_size)]
        )

    def work(self, input_items, output_items):
        x = input_items[0][:]
        x_min = np.min(x)
        x_max = np.max(x)
        N = 2 ** self.num_bits
        delta = (x_max - x_min) / N
        y = np.arange(x_min + delta / 2, x_max, delta)
        t = np.array([(y[0:N - 1] + y[1:N]) / 2])
        t = np.insert(t, 0, x_min - 1)
        t = np.insert(t, np.size(t), x_max + 1)
        xq = np.zeros_like(x)
        for i in range(N):
            xq = xq + ((t[i] <= x) & (x < t[i + 1])) * y[i]
        output_items[0][:] = xq
        return len(output_items[0])


