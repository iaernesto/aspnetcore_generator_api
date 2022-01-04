using Xunit;
using System;
using System.Linq;
using api.Controllers;


namespace tests
{
    public class RangeTests
    {
        [Fact]
        public void CountShouldControlNumberOfResults()
        {
            var range = new api.Controllers.Range { Count = 3 };
            var generated = range.Of(() => "");

            Assert.Equal(3, generated.Count());
        }
    }
}
