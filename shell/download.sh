#!/bin/bash
${path_head} = path
${productname} = prod
functions copy(path,prod)
{
    echo "start downloading . . ."
scp pfx@192.168.78.219:~/pfx/${path_head}/out/target/product/${productname}/*.img ~/project/imge/newimage/

    echo "download finished! in the directoy ./image/newimage"

}


