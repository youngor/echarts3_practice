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
                ['2017/6/30',13],
['2017/6/29',19],
['2017/6/28',27],
['2017/6/27',21],
['2017/6/26',9],
['2017/6/25',8],
['2017/6/24',16],
['2017/6/23',11],
['2017/6/22',15],
['2017/6/21',23],
['2017/6/20',14],
['2017/6/19',20],
['2017/6/18',7],
['2017/6/17',12],
['2017/6/16',10],
['2017/6/15',17],
['2017/6/14',21],
['2017/6/13',21],
['2017/6/12',10],
['2017/6/11',10],
['2017/6/10',22],
['2017/6/9',18],
['2017/6/8',16],
['2017/6/7',23],
['2017/6/6',24],
['2017/6/5',23],
['2017/6/4',9],
['2017/6/3',15],
['2017/6/2',24],
['2017/6/1',14],
['2017/5/31',17],
['2017/5/30',7],
['2017/5/29',12],
['2017/5/28',12],
['2017/5/27',25],
['2017/5/26',21],
['2017/5/25',21],
['2017/5/24',23],
['2017/5/23',34],
['2017/5/22',13],
['2017/5/21',18],
['2017/5/20',11],
['2017/5/19',21],
['2017/5/18',27],
['2017/5/17',17],
['2017/5/16',37],
['2017/5/15',21],
['2017/5/14',16],
['2017/5/13',10],
['2017/5/12',20],
['2017/5/11',21],
['2017/5/10',24],
['2017/5/9',26],
['2017/5/8',23],
['2017/5/7',17],
['2017/5/6',25],
['2017/5/5',28],
['2017/5/4',35],
['2017/5/3',20],
['2017/5/2',18],
['2017/5/1',17],
 //['a',20],['b',50],['c',40],
                ]
        }
    ]
};