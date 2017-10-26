option = {
    backgroundColor: '#ffffff',
    animation: false, // save image...

    tooltip: {
        trigger: 'axis',
        position: function (pt) {
            return [pt[0], '10%'];
        }
    },
    title: {
        left: 'center',
        text: '面积图',
    },
    
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: [
            '2017/6/30',
'2017/6/29',
'2017/6/28',
'2017/6/27',
'2017/6/26',
'2017/6/25',
'2017/6/24',
'2017/6/23',
'2017/6/22',
'2017/6/21',
'2017/6/20',
'2017/6/19',
'2017/6/18',
'2017/6/17',
'2017/6/16',
'2017/6/15',
'2017/6/14',
'2017/6/13',
'2017/6/12',
'2017/6/11',
'2017/6/10',
'2017/6/9',
'2017/6/8',
'2017/6/7',
'2017/6/6',
'2017/6/5',
'2017/6/4',
'2017/6/3',
'2017/6/2',
'2017/6/1',
'2017/5/31',
'2017/5/30',
'2017/5/29',
'2017/5/28',
'2017/5/27',
'2017/5/26',
'2017/5/25',
'2017/5/24',
'2017/5/23',
'2017/5/22',
'2017/5/21',
'2017/5/20',
'2017/5/19',
'2017/5/18',
'2017/5/17',
'2017/5/16',
'2017/5/15',
'2017/5/14',
'2017/5/13',
'2017/5/12',
'2017/5/11',
'2017/5/10',
'2017/5/9',
'2017/5/8',
'2017/5/7',
'2017/5/6',
'2017/5/5',
'2017/5/4',
'2017/5/3',
'2017/5/2',
'2017/5/1',
'2017/4/30',
'2017/4/29',
'2017/4/28',
'2017/4/27',
'2017/4/26',
'2017/4/25',
'2017/4/24',
'2017/4/23',
'2017/4/22',
'2017/4/21',
'2017/4/20',
'2017/4/19',
'2017/4/18',
'2017/4/17',
'2017/4/16',
'2017/4/15',
'2017/4/14',
'2017/4/13',
'2017/4/12',
'2017/4/11',
'2017/4/10',
'2017/4/9',
'2017/4/8',
'2017/4/7',
'2017/4/6',
'2017/4/5',
'2017/4/4',
'2017/4/3',
'2017/4/2',
'2017/4/1',

        ]
        //['a','b','c']
    },
    yAxis: {
        type: 'value',
        boundaryGap: [0, '100%']
    },
    
    series: [
        {
            name:'数据',
            type:'line',
            smooth:true,
            symbol: 'none',
            sampling: 'average',
            itemStyle: {
                normal: {
                    color: 'rgb(255, 70, 131)'
                }
            },
            areaStyle: {
                normal: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                        offset: 0,
                        color: 'rgb(255, 158, 68)'
                    }, {
                        offset: 1,
                        color: 'rgb(255, 70, 131)'
                    }])
                }
            },
            data: [
                ['2017/6/30',27],
['2017/6/29',20],
['2017/6/28',19],
['2017/6/27',12],
['2017/6/26',17],
['2017/6/25',23],
['2017/6/24',27],
['2017/6/23',11],
['2017/6/22',28],
['2017/6/21',22],
['2017/6/20',31],
['2017/6/19',36],
['2017/6/18',22],
['2017/6/17',38],
['2017/6/16',28],
['2017/6/15',10],
['2017/6/14',51],
['2017/6/13',39],
['2017/6/12',26],
['2017/6/11',45],
['2017/6/10',38],
['2017/6/9',62],
['2017/6/8',46],
['2017/6/7',18],
['2017/6/6',47],
['2017/6/5',37],
['2017/6/4',27],
['2017/6/3',23],
['2017/6/2',27],
['2017/6/1',37],
['2017/5/31',25],
['2017/5/30',16],
['2017/5/29',26],
['2017/5/28',25],
['2017/5/27',34],
['2017/5/26',29],
['2017/5/25',37],
['2017/5/24',36],
['2017/5/23',34],
['2017/5/22',47],
['2017/5/21',38],
['2017/5/20',42],
['2017/5/19',47],
['2017/5/18',36],
['2017/5/17',32],
['2017/5/16',28],
['2017/5/15',29],
['2017/5/14',37],
['2017/5/13',46],
['2017/5/12',39],
['2017/5/11',36],
['2017/5/10',40],
['2017/5/9',34],
['2017/5/8',41],
['2017/5/7',49],
['2017/5/6',35],
['2017/5/5',24],
['2017/5/4',39],
['2017/5/3',38],
['2017/5/2',41],
['2017/5/1',31],
['2017/4/30',35],
['2017/4/29',32],
['2017/4/28',26],
['2017/4/27',35],
['2017/4/26',43],
['2017/4/25',53],
['2017/4/24',39],
['2017/4/23',46],
['2017/4/22',39],
['2017/4/21',42],
['2017/4/20',22],
['2017/4/19',24],
['2017/4/18',38],
['2017/4/17',63],
['2017/4/16',24],
['2017/4/15',32],
['2017/4/14',26],
['2017/4/13',29],
['2017/4/12',35],
['2017/4/11',37],
['2017/4/10',35],
['2017/4/9',27],
['2017/4/8',24],
['2017/4/7',32],
['2017/4/6',30],
['2017/4/5',27],
['2017/4/4',18],
['2017/4/3',14],
['2017/4/2',29],
['2017/4/1',22],
 //['a',20],['b',50],['c',40],
                ]
        }
    ]
};
