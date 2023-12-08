#include "VGA.h"

#define TILE_HEIGHT 20
#define TILE_WIDTH 20
#define MAP_HEIGHT 24
#define MAP_WIDTH 32


int tiles [768] = {2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,
2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,2,
2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,2,
2,1,1,2,2,2,2,2,2,2,1,1,2,1,1,2,2,2,2,2,2,2,2,2,2,2,1,1,2,1,1,2,
2,1,1,1,1,1,1,1,1,2,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,2,
2,1,1,1,1,1,1,1,1,2,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,2,
2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2,2,2,1,1,2,1,1,2,1,1,2,
2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,2,1,1,2,1,1,1,1,1,1,2,1,1,2,1,1,2,
2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,2,1,1,2,1,1,1,1,1,1,2,1,1,2,1,1,2,
2,1,1,2,2,2,2,2,2,2,2,2,2,1,1,2,3,3,2,1,1,2,2,2,2,2,2,2,2,1,1,2,
2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,2,3,3,2,1,1,1,1,1,1,2,1,1,2,1,1,2,
2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,2,2,2,2,1,1,1,1,1,1,2,1,1,2,1,1,2,
2,2,2,2,2,2,2,2,2,2,1,1,2,1,1,1,1,1,1,2,2,2,2,1,1,1,1,1,2,1,1,2,
2,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,2,
2,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,1,1,2,1,1,2,1,1,2,1,1,2,1,1,2,
2,1,1,2,2,2,2,1,1,2,2,2,2,1,1,1,1,1,1,2,1,1,2,1,1,2,1,1,1,1,1,2,
2,1,1,2,1,1,2,1,1,2,1,1,2,1,1,1,1,1,1,2,1,1,2,1,1,2,1,1,1,1,1,2,
2,1,1,2,1,1,2,1,1,2,1,1,2,1,1,2,2,2,2,2,1,1,2,2,2,2,1,1,2,1,1,2,
2,1,1,2,1,1,2,1,1,2,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,
2,1,1,2,1,1,2,1,1,2,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,2,
2,1,1,2,1,1,2,2,2,2,1,1,2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,
2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,
2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,
2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2 };

int tileIndexArray[9] = {0,0,0,0,0,0,0,0,0};


void DrawTiles(void *virtual_base){
    int i=0; 
    for(i=0;i<768;i++){
        int x = i % 32 * 20;
        int y = i / 32 * 20;
        switch(tiles[i])
        {
            case 1:
                VGA_box(x,y,x+20,y+20,0x0000,virtual_base);
                break;
            case 2:
                VGA_box(x,y,x+20,y+20, 0xFFAB, virtual_base);
                break;
            case 3:
                VGA_box(x,y,x+20,y+20, 0xFFFD,virtual_base);
                break;
        }
    }
}

int TileCollision(int *Player_x, int *Player_y, void *virtual_base)
{
    int playerIndex = (*Player_y / TILE_HEIGHT * MAP_WIDTH) + (*Player_x / TILE_WIDTH);
            tileIndexArray[0] = playerIndex - 1 - MAP_WIDTH;
            tileIndexArray[1] = playerIndex - MAP_WIDTH;
            tileIndexArray[2] = playerIndex - MAP_WIDTH + 1;
            tileIndexArray[3] = playerIndex - 1;
            tileIndexArray[4] = playerIndex;
            tileIndexArray[5] = playerIndex + 1;
            tileIndexArray[6] = playerIndex + MAP_WIDTH - 1;
            tileIndexArray[7] = playerIndex + MAP_WIDTH;
            tileIndexArray[8] = playerIndex + MAP_WIDTH + 1;

            
            //[0][1][2]
            //[3][*][5]
            //[6][7][8]

            int i;
            for (i = 0; i < 9; i++)
            {
                if (tileIndexArray[i] > -1 && tileIndexArray[i] < MAP_HEIGHT * MAP_WIDTH)
                {
                    switch(tiles[tileIndexArray[i]])
                    {
                        case 1:
                        //air tile do nothing
                        break;

                        case 2: // 2 is wall tile
                        switch(i)
                        {
                            case 0: // top left tile
                                if(*Player_y -10 <= ( (tileIndexArray[i] / MAP_WIDTH) + 1 ) * TILE_HEIGHT){ // top
                                    if(*Player_x -8 <= ( (tileIndexArray[i] % MAP_WIDTH) + 1 ) * TILE_HEIGHT){ //left
                                        *Player_y = ((tileIndexArray[i] / MAP_WIDTH) + 1 ) * TILE_HEIGHT + 10;
                                    }
                                
                                }else if(*Player_x -10 <= ( (tileIndexArray[i] % MAP_WIDTH) + 1 ) * TILE_HEIGHT){
                                    if(*Player_y -8 <= ( (tileIndexArray[i] / MAP_WIDTH) + 1 ) * TILE_HEIGHT){
                                         *Player_x = ((tileIndexArray[i] % MAP_WIDTH) + 1 ) * TILE_HEIGHT + 10;
                                    }
                                    
                                }
                                break;
                            case 1: // top tile
                                if(*Player_y -10 <= ( (tileIndexArray[i] / MAP_WIDTH) + 1 ) * TILE_HEIGHT){
                                    *Player_y = ((tileIndexArray[i] / MAP_WIDTH) + 1 ) * TILE_HEIGHT + 10;
                                }
                                break;
                            case 3: //left tile
                                if(*Player_x -10 <= ( (tileIndexArray[i] % MAP_WIDTH) + 1 ) * TILE_HEIGHT){
                                    *Player_x = ((tileIndexArray[i] % MAP_WIDTH) + 1 ) * TILE_HEIGHT + 10;
                                }  
                                break;
                            case 5: // right tile
                                if(*Player_x +12 >= ( (tileIndexArray[i] % MAP_WIDTH)) * TILE_HEIGHT){
                                    *Player_x = ((tileIndexArray[i] % MAP_WIDTH)) * TILE_HEIGHT - 12;
                                } 
                                break;
                            case 7: // bottom tile
                                if(*Player_y +11 >= ( (tileIndexArray[i] / MAP_WIDTH)) * TILE_HEIGHT){
                                    *Player_y = ((tileIndexArray[i] / MAP_WIDTH)) * TILE_HEIGHT - 11;
                                } 
                                break;
                            default:
                            //do nothing
                            break;
                        }
                        break;
                        case 3: // 3 is win tile
                        if(i == 4){
                            return 0x3FF;
                        }
                        break;
                        default:
                        // jump scare
                        break;
                    }
                }
            }
         return 0;



}